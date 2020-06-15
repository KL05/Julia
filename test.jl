#v.2
function inputStr(mensagem::String)::String # armazenar resultado em txt
    println(mensagem)
    return readline()
end

function gerar_grafo()::Dict{String,Dict{String,Float64}}
    arquivo = open("C:\\Users\\Carlos Eduardo\\arquivo.txt", "r");
    arquivo = split(read(arquivo, String), keepempty = true)

    grafo::Dict{String,Dict{String,Float64}} = Dict()
    i::UInt64, j::UInt64, contador::UInt64 = 1, 1, 0
    aux_no = Array[]
    FloatOuString = Union{Float64,AbstractString}
    push!(aux_no,FloatOuString[])

    for linha in arquivo
        contador += 1

        if linha == ""
            continue
        elseif j % 3 != 0
            push!(aux_no[i], linha)
        else
            linha = parse(Float64, linha)
            push!(aux_no[i], linha)
            if contador < length(arquivo) # limitar a quantidade de array
                push!(aux_no,FloatOuString[])
            end
            i += 1
        end

        j += 1
    end

    qtd_no::UInt64 = i-1

    for i = 1:qtd_no
        grafo[aux_no[i][1]] = Dict()
        grafo[aux_no[i][2]] = Dict()
    end

    for i = 1:qtd_no
        grafo[aux_no[i][1]][aux_no[i][2]] = aux_no[i][3]
        grafo[aux_no[i][2]][aux_no[i][1]] = aux_no[i][3]
    end

    #close(arquivo);
    return grafo
end

function dijkstra(no_inicial::String, no_final::String, grafo::Dict{String,Dict{String,Float64}})::Nothing
    nao_visitado = grafo
    menor_distancia::Dict{String,Float64} = Dict()
    no_anterior::Dict{String,String} = Dict()
    caminho = String[]
    infinito = Inf

    [menor_distancia[no] = infinito for (no,) in nao_visitado]

    menor_distancia[no_inicial] = 0.0
    no = no_inicial

    while length(nao_visitado) != 0
        aux_grafo = nao_visitado[no]

        for (aux_no,peso) = aux_grafo
            if peso + menor_distancia[no] < menor_distancia[aux_no]
                menor_distancia[aux_no] = peso + menor_distancia[no]
                no_anterior[aux_no] = no
            end
        end

        pop!(nao_visitado,no)
        no = nothing

        for (aux_no,peso) in nao_visitado
            if no == nothing
                no = aux_no
            elseif menor_distancia[aux_no] < menor_distancia[no]
                no = aux_no
            end
        end

        if no == no_final
            break
        end
    end

    no_atual = no_final

    while no_atual != no_inicial
        pushfirst!(caminho,no_atual)
        no_atual = no_anterior[no_atual]
    end

    pushfirst!(caminho,no_inicial)

    println("Peso mínimo: $(menor_distancia[no_final])")
    println("Caminho mínimo: $caminho")
    return nothing
end

function main()
    no_inicial = inputStr("Digite o nó inicial: ")
    no_final = inputStr("Digite o nó final: ")

    grafo = gerar_grafo()

    println("")

    dijkstra(no_inicial, no_final, grafo)
end

@time main()
