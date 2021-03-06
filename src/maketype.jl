function maketype(name,
                  f,
                  f_func,
                  f_symfuncs,
                  g,
                  g_func,
                  jumps,
                  regular_jumps,
                  jump_rate_expr,
                  jump_affect_expr,
                  p_matrix,
                  syms;
                  params = Symbol[],
                  pfuncs=Vector{Expr}(0),
                  symjac=Matrix{SymEngine.Basic}(0,0),
                  reactions=Vector{ReactionStruct}()
                  )

    typeex = :(mutable struct $name <: AbstractReactionNetwork
        f::Function
        f_func::Vector{Expr}
        f_symfuncs::Matrix{SymEngine.Basic}
        g::Function
        g_func::Vector{Any}
        jumps::Tuple{AbstractJump,Vararg{AbstractJump}}
        regular_jumps::RegularJump
        jump_rate_expr::Tuple{Any,Vararg{Any}}
        jump_affect_expr::Tuple{Vector{Expr},Vararg{Vector{Expr}}}
        p_matrix::Array{Float64,2}
        syms::Vector{Symbol}
        params::Vector{Symbol}
        symjac::Matrix{SymEngine.Basic}
        reactions::Vector{ReactionStruct}
    end)
    # Make the default constructor
    constructorex = :($(name)(;
                  $(Expr(:kw,:f,f)),
                  $(Expr(:kw,:f_func,f_func)),
                  $(Expr(:kw,:g,g)),
                  $(Expr(:kw,:g_func,g_func)),
                  $(Expr(:kw,:jumps,jumps)),
                  $(Expr(:kw,:regular_jumps,regular_jumps)),
                  $(Expr(:kw,:jump_rate_expr,jump_rate_expr)),
                  $(Expr(:kw,:jump_affect_expr,jump_affect_expr)),
                  $(Expr(:kw,:p_matrix,p_matrix)),
                  $(Expr(:kw,:f_symfuncs,f_symfuncs)),
                  $(Expr(:kw,:syms,syms)),
                  $(Expr(:kw,:params,params)),
                  $(Expr(:kw,:symjac,symjac)),
                  $(Expr(:kw,:reactions,reactions))) =
                  $(name)(
                      f,
                      f_func,
                      f_symfuncs,
                      g,
                      g_func,
                      jumps,
                      regular_jumps,
                      jump_rate_expr,
                      jump_affect_expr,
                      p_matrix,
                      syms,
                      params,
                      symjac,
                      reactions
                      )) |> esc

                      #f_funcs,symfuncs,pfuncs,syms,symjac) |> esc

    # Make the type instance using the default constructor
    typeex,constructorex
end
