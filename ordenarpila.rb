require 'terminal-table'
def limpiar_pantalla
system('clear')
end
class Pila
        def initialize
            @pila = {
                tope: nil,
                size: 0,
                esta_vacia: true,
                imprecion: false
            }
            @pila_aux = {
                tope: nil,
                size:0,
                esta_vacia: true
            }
            @pasos=[]
            @cadena=""
        end


 #INSERTAR VALORES MENORES EN PILA AUX


        def insertar_en_aux(valor)

            nodo = {
                valor: valor,
                siguiente: nil,
            }
            if @pila_aux[:esta_vacia]
                @pila_aux[:tope]=nodo
                @pila_aux[:esta_vacia]=false
                @pila_aux[:size]+=1
            else
                tope=@pila_aux[:tope]
                nodo[:siguiente]=tope
                @pila_aux[:tope]=nodo
                @pila_aux[:size]+=1
            end
        end


    #INSERTAR DATOS MENORES A LA PILA


        def ingresar_menores
            if @pila_aux[:tope]!=nil
            for i in 1..@pila_aux[:size]
            valor = @pila_aux[:tope][:valor]
            nodo = {
                valor:valor,
                siguiente: nil
            }
            tope = @pila[:tope]
            nodo[:siguiente]=tope
            @pila[:tope]=nodo
            siguiente = @pila_aux[:tope][:siguiente]
            @pila_aux[:tope]=siguiente
            @pasos.push(mostrar_pila())
            end
        end
        end


        #APARTAR VALORES MENORES DE LA PILA PRINCIPAL


        def apartar_menores(num)
            nodo ={
                valor: num,
                siguiente: nil
            }
            contador=1
            while contador<=@pila[:size]
                valor = @pila[:tope][:valor]
                if num>valor && @pila[:tope][:siguiente]==nil
                    insertar_en_aux(valor)
                    @pasos.push("ELIMINAR #{valor}")
                    @pila[:tope]=nodo
                    @pila[:size]+=1
                    contador=@pila[:size]+1
                    @pasos.push(mostrar_pila())
                elsif num ==valor
                    tope = @pila[:tope]
                    nodo[:siguiente]=tope
                    @pila[:tope]=nodo
                    @pila[:size]+=1
                    contador=@pila[:size]+1
                    @pasos.push(mostrar_pila())
                elsif num>valor
                    insertar_en_aux(valor)
                    @pasos.push("ELIMINAR #{valor}")
                    @pila[:tope]=@pila[:tope][:siguiente]
                    @pasos.push(mostrar_pila())
                elsif num<valor
                    tope = @pila[:tope]
                    nodo[:siguiente]=tope
                    @pila[:tope]=nodo
                    @pila[:size]+=1
                    contador=@pila[:size]+1
                    @pasos.push(mostrar_pila())
                end
                contador+=1
            end
            ingresar_menores()
            @pila_aux[:tope]=nil
            @pila_aux[:size]=0
            @pila_aux[:esta_vacia]=true
        end


        #ORDENAR PILA PRINCIPAL


        def ordenar_pila(array=[])
            size = array.size
            for i in 0..size-1
              @pasos.push("INGRESAR #{array[i]}")
                nodo = {
                    valor: array[i],
                    siguiente: nil
                }
                if @pila[:esta_vacia]
                    @pila[:tope]=nodo
                    @pila[:esta_vacia]=false
                    @pila[:size]+=1

                else
                    apartar_menores(array[i])
                end
            end
        end


        #MOSTRAR PILA PRINCIPAL ORDENADA


        def mostrar_pila
            elemento=@pila[:tope]
            @cadena=""
            if elemento ==nil
              @cadena=""
              @cadena
            elsif elemento[:siguiente]==nil
                @cadena+="#{elemento[:valor]}"
                @cadena
            else
                @cadena+="#{elemento[:valor]}"
                begin
                    elemento = elemento[:siguiente]
                    @cadena+=" --> #{elemento[:valor]}"
                end while elemento[:siguiente]!=nil
                @cadena
            end
        end

        #MOSTRAR EN LA TABLA


        def mostrar_tabla(array_anterior)
  tabla = Terminal::Table.new do |a|
  a.title= 'ORDENAR DATOS DE LA PILA'
  a.headings = [{value:array_anterior, alignment: :center}]
  a.add_row([{value:mostrar_pila(), alignment: :center}])
  end
  puts tabla
      end


      #MOSTRAR EN LA TABLA PASO A PASO

      def tabla_pasos(contador,array_anterior)
        aux=0
  tabla = Terminal::Table.new do |a|
  a.title= "ELEMENTOS A ORDENAR: #{array_anterior} "
  a.headings = [{value:'DATO', alignment: :center},{value:'ESTRUCTURA', alignment: :center}]
  for i in 0..contador-1
  a.add_row([
  aux+=1,
  @pasos[i]
  ])
end
  end
  return tabla
      end


      #MOSTRAR TODOS LOS PASOS


      def mostrar_pasos(array_anterior)
          size=@pasos.size
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


      def pasos_pila
        size = @pasos.size
        return size
      end


      def limpiar_pila
        @pila[:tope]=nil
        @pila[:size]=0
        @pila[:esta_vacia]=true
        @pasos.clear
      end
end

