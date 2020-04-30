function inputInt(msg::String)
    println(msg)
    parse(UInt64, readline())
end

function inputFloat(msg::String)
    println(msg)
    parse(Float64, readline())
end

function newton(x0::Float64,h::Float64,tolerancia::Float64,maxIteracao::UInt64)
    fx = f(x0)
    if fx == 0
        println(" Zero da função f: x = $x")
    else
        for iteracao = 1:maxIteracao
            derivada = central(x0,h)
            if derivada == 0
                error("Divisão por 0 na $iteracao iteracao!")
            end
            x1 = x0 - fx/derivada
            if abs(x1 - x0) < tolerancia
                return println(" Zero da função f: x = $x1.\n Número de iterações: $iteracao.")
            end
            x0 = x1
            fx = f(x0)
        end
        error("Atingiu o número máximo de iterações!")
    end
end

f(x::Float64) = x^2 - 2

progressiva(x::Float64,h::Float64,fx::Float64) = (f(x+h) - fx)/h
regressiva(x::Float64,h::Float64,fx::Float64) = (fx - f(x-h))/h
central(x::Float64,h::Float64) = (f(x+h) - f(x-h))/(2*h)

x0 = inputFloat("Digite o ponto de partida: ")
h = inputFloat("Digite o tamanho de h: ")
tolerancia = inputFloat("Digite a tolerância: ")
maxIteracao = inputInt("Digite o número máximo de iterações:")

newton(x0,h,tolerancia,maxIteracao)
