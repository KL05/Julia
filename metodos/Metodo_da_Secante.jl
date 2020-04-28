function inputInt(msg::String)
    println(msg)
    parse(UInt64, readline())
end

function inputFloat(msg::String)
    println(msg)
    parse(Float64, readline())
end

function secante(x0::Float64,x1::Float64,tolerancia::Float64,maxIteracao::UInt64)
    fx0 = f(x0)
    fx1 = f(x1)
    if fx0 == 0
        println(" Zero da função f: x = $x0")
    elseif fx1 == 0
        println(" Zero da função f: x = $x1")
    else
        for iteracao = 1:maxIteracao
            if fx1 == fx0
                error("Divisão por 0 na iteracao $iteracao !")
            end
            x2 = x1 - fx1*(x1-x0)/(fx1-fx0)
            if abs(x2 - x1) < tolerancia
                return println(" Zero da função f: x = $x2.\n Número de iterações: $iteracao.")
            end
            x0 = x1
            x1 = x2
            fx0 = f(x0)
            fx1 = f(x1)
        end
        error("Atingiu o número máximo de iterações!")
    end
end

f(x::Float64) = x^2 - 2

x0 = inputFloat("Digite o primeiro ponto de partida: ")
x1 = inputFloat("Digite o segundo ponto de partida: ")
tolerancia = inputFloat("Digite a tolerância: ")
maxIteracao = inputInt("Digite o número máximo de iterações:")

secante(x0,x1,tolerancia,maxIteracao)
