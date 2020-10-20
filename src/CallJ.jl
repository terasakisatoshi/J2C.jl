module CallJ

TYPES=[Cdouble, Cint]

Base.@ccallable greet()::Cvoid = println("Hello World!")

for T in TYPES
    @eval Base.@ccallable function jlmax(cx::Ptr{$T}, len::Csize_t)::$T
        x = unsafe_wrap(Array, cx, (len,))
        return  maximum(x)
    end
end

for T in TYPES
    @eval Base.@ccallable function jlmin(cx::Ptr{$T}, len::Csize_t)::$T
        x = unsafe_wrap(Array, cx, (len,))
        return  minimum(x)
    end
end

for T in TYPES
    @eval Base.@ccallable function jlminus(cx::Ptr{$T}, len::Csize_t)::Cint
        x = unsafe_wrap(Array, cx, (len,))
        x .*= -1.
        return 0
    end
end

for T in TYPES
    @eval Base.@ccallable function jlreverse(cx::Ptr{$T}, len::Csize_t)::Cint
        x = unsafe_wrap(Array, cx, (len,))
        reverse!(x)
        return 0
    end
end

end # module
