function inputInt(msg::String)
    println(msg)
    parse(UInt64, readline())
end

function inputFloat(msg::String)
    println(msg)
    parse(Float64, readline())
end

function bissecao(a::Float64,b::Float64,tolerancia::Float64,maxIteracao::UInt64)
    fa = f(a)
    fb = f(b)
    if fa == 0
        println(" Zero da função f: x = $a")
    elseif fb == 0
        println(" Zero da função f: x = $b")
    else
        fa*fb < 0 || error("Não foi possível determinar o zero da função f no intervalo ($a,$b), pois f($a)*f($b) = $(f(a)*f(b)) > 0.")
        iteracao = 1
        local x
        while abs(b-a)/2 > tolerancia
            x = (a+b)/2
            fx = f(x)
            if fx == 0
                break
            elseif fa*fx < 0.0
                b = x
            else
                a = x
                fa = fx
            end
            iteracao != maxIteracao || error("Atingiu o número máximo de iterações! \na = $a, b = $b, f($x) = $fx")
            iteracao += 1
        end
        println(" Zero da função f: x = $x. \n Número de iterações: $iteracao.")
    end
end

f(x::Float64) = x^2 - 2

a = inputFloat("Digite o extremo esquerdo: ")
b = inputFloat("Digite o extremo direito: ")
tolerancia = inputFloat("Digite a tolerância: ")
maxIteracao = inputInt("Digite o número máximo de iterações: ")

bissecao(a,b,tolerancia,maxIteracao)
