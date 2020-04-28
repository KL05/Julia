function inputInt(msg::String)
    println(msg)
    parse(UInt64, readline())
end

function inputFloat(msg::String)
    println(msg)
    parse(Float64, readline())
end

function pontoFixo(x0::Float64,tolerancia::Float64,maxIteracao::UInt64)
    fx = f(x0)
    if fx == 0
        println(" Zero da função f: x = $x. \n Número de iterações: Nenhuma")
    else
        for iteracao = 1:maxIteracao
            x1 = g(x0)
            if abs(x1 - x0) < tolerancia
                return println(" Ponto fixo de g e zero da função f: x = $x1. \n Número de iterações: $iteracao.")
            end
            x0 = x1
        end
        error("Atingiu o número máximo de iterações!")
    end
end

f(x::Float64) = exp(x) - x - 2
g(x::Float64) = exp(x) - 2

x0 = inputFloat("Digite o ponto de partida: ")
tolerancia = inputFloat("Digite a tolerância: ")
maxIteracao = inputInt("Digite o número máximo de iterações:")

pontoFixo(x0,tolerancia,maxIteracao)
