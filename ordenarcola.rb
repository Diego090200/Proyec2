require 'terminal-table'
class Cola
  def initialize
    @cola = {
    tope: nil,
    fondo: nil,
    size: 0,
    esta_vacia: true
  }
  @cola_mayor ={
    tope: nil,
    fondo: nil,
    size: 0,
    esta_vacia: true
  }
  @cola_menor={
    tope: nil,
    fondo: nil,
    size: 0,
    esta_vacia: true
  }
  @paso=[]
  @cadena1=""
    end

    #INGRESAR MENORES EN LA COLA PRINCIPAL


def ingresar_menores 
      for i in 1..@cola_menor[:size]
        if @cola[:tope]==nil
          valor = @cola_menor[:tope][:valor]
            nodo = {
                valor:valor,
                siguiente: nil
            }
            @cola[:tope]=nodo
            @cola[:fondo]=nodo
            @cola[:esta_vacia]=false

            @cola_menor[:tope]=@cola_menor[:tope][:siguiente]
        else
            valor = @cola_menor[:tope][:valor]
            nodo = {
                valor:valor,
                siguiente: nil
            }
            fondo = @cola[:fondo]
            fondo[:siguiente]=nodo
            @cola[:fondo]=nodo
            siguiente = @cola_menor[:tope][:siguiente]
            @cola_menor[:tope]=siguiente

          end
        @paso.push(mostrar_cola())
        end
    end
    
    
    #INGRESAR MAYORES EN LA COLA PRINCIPAL


      def ingresar_mayores 
      for i in 1..@cola_mayor[:size]
            valor = @cola_mayor[:tope][:valor]
            nodo = {
                valor:valor,
                siguiente: nil
            }
            fondo = @cola[:fondo]
            fondo[:siguiente]=nodo
            @cola[:fondo]=nodo
            @cola_mayor[:tope]=@cola_mayor[:tope][:siguiente]
            @paso.push(mostrar_cola())
          end
  end


#INGRESAR COLA AUX MENOR


    def ingresar_cola_menor(valor)
        nodo = {
                valor: valor,
                siguiente: nil,
            }
            if @cola_menor[:esta_vacia]
                @cola_menor[:tope]=nodo
                @cola_menor[:fondo]=nodo
                @cola_menor[:esta_vacia]=false
                @cola_menor[:size]+=1
            else
                fondo=@cola_menor[:fondo]
                fondo[:siguiente]=nodo
                @cola_menor[:fondo]=nodo
                @cola_menor[:size]+=1
            end
    end


    #INGRESAR COLA AUX MAYOR

    def ingresar_cola_mayor(valor) 
        nodo = {
                valor: valor,
                siguiente: nil,
            }
            if @cola_mayor[:esta_vacia]
                @cola_mayor[:tope]=nodo
                @cola_mayor[:fondo]=nodo
                @cola_mayor[:esta_vacia]=false
                @cola_mayor[:size]+=1
            else
                fondo=@cola_mayor[:fondo]
                fondo[:siguiente]=nodo
                @cola_mayor[:fondo]=nodo
                @cola_mayor[:size]+=1
            end
    end



    #VACIAR COLAS AUX


    def vaciar(nodo,num)
            menor=0
            while @cola[:tope]!=nil
                valor = @cola[:tope][:valor]
                  if num>valor
                    menor+=1
                    ingresar_cola_menor(valor)
                    @paso.push("APARTAR MENOR: #{valor}")
                  elsif num<valor
                    ingresar_cola_mayor(valor)
                    @paso.push("APARTAR MAYOR: #{valor}")
                  elsif num == valor
                    ingresar_cola_mayor(valor)
                    @paso.push("APARTAR IGUAL: #{valor}")
                  end

                @cola[:tope]=@cola[:tope][:siguiente]
                end

                @cola[:fondo]=nil
                @cola[:tope]=nil
                @cola[:esta_vacia]=true

                if menor>0
                  ingresar_menores()

                  fondo=@cola[:fondo]
                  fondo[:siguiente]=nodo
                  @cola[:fondo]=nodo
                  @cola[:size]+=1
                  @paso.push(mostrar_cola())
                  ingresar_mayores()
                else
                  @cola[:tope]=nodo
                  @cola[:fondo]=nodo
                  @cola[:size]+=1
                  @cola[:esta_vacia]=false
                  @paso.push(mostrar_cola())
                  ingresar_mayores()
                end

                @cola_mayor[:tope]=nil
                @cola_mayor[:fondo]=nil
                @cola_mayor[:size]=0
                @cola_mayor[:esta_vacia]=true

                @cola_menor[:tope]=nil
                @cola_menor[:fondo]=nil
                @cola_menor[:size]=0
                @cola_menor[:esta_vacia]=true

    end


    #ORDENAR LA COLA


    def ordenar_cola(array=[])
            size = array.size
            for i in 0..size-1
              @paso.push("INGRESAR #{array[i]}")
                nodo = {
                    valor: array[i],
                    siguiente: nil
                }
                if @cola[:esta_vacia]
                    @cola[:tope]=nodo
                    @cola[:fondo]=nodo
                    @cola[:esta_vacia]=false
                    @cola[:size]+=1

                else
                  if array[i]>@cola[:fondo][:valor]
                    fondo = @cola[:fondo]
                    fondo[:siguiente]=nodo
                    @cola[:fondo]=nodo
                    @cola[:size]+=1
                    @paso.push(mostrar_cola())
                  else
                    vaciar(nodo,array[i])
                  end
                end
            end
        end

        #MOSTRAR COLA ORDENADA


        def mostrar_cola
          elemento=@cola[:tope]
            @cadena1=""
            if elemento ==nil
              @cadena1=""
              @cadena1
            elsif elemento[:siguiente]==nil
                @cadena1+="#{elemento[:valor]}"
                @cadena1
            else
                @cadena1+="#{elemento[:valor]}"
                begin
                    elemento = elemento[:siguiente]
                    @cadena1+=" --> #{elemento[:valor]}"
                end while elemento[:siguiente]!=nil
              @cadena1
            end
        end

        #IMPRIMIR EN LA TABLA


  def mostrar_tabla(array_anterior)
  tabla = Terminal::Table.new do |a|
  a.title= 'ORDENAR DATOS DE LA COLA'
  a.headings = [{value:array_anterior, alignment: :center}]
  a.add_row([{value:mostrar_cola(), alignment: :center}])
  end
  puts tabla
      end


      #TABLA PASO A PASO


  def tabla_pasos(contador,array_anterior)
        aux=0
  tabla = Terminal::Table.new do |a|
  a.title= "ELEMENTOS A ORDENAR  #{array_anterior} "
  a.headings = [{value:'DATO', alignment: :center},{value:'ESTRUCTURA', alignment: :center}]
  for i in 0..contador-1
  a.add_row([
  aux+=1,
  @paso[i]
  ])
end
  end
  return tabla
      end

      #MOSTRAR PASOS

      def mostrar_paso(array_anterior)
          size=@paso.size
          contador=0
        while contador<size
          limpiar_pantalla
          print 'INGRESE (s) PARA IMPRIMIR PASO A PASO O INGRESE (f) PARA IMPRIMIR TODOS LOS PASOS '
          opc=gets.chomp
          if opc == 's'
          puts tabla_pasos(contador+=1,array_anterior)
          gets
          elsif opc == 'f'
            contador=size
            puts tabla_pasos(size,array_anterior)
            puts 'FIN ESTRUCTURA'
            gets
          else
            puts 'OPCION INCORRECTA'
          end
        end
      end

      def pasos_cola
        size = @paso.size
        return size
      end

      def limpiar_cola
        @cola[:tope]=nil
        @cola[:size]=0
        @cola[:fondo]=nil
        @cola[:esta_vacia]=true
        @paso.clear
      end
end

