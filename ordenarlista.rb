require 'terminal-table'
class Lista


  def initialize
    @lista ={
      tope: nil,
      fondo: nil,
      size: 0,
      esta_vacia: true
    }
    @cadenaL=""
    @pasoL=[]
  end


  #OBTENER DATO ANTERIOR

  def obtener_anterior(contador)
    elemento=@lista[:tope]
    for i in 1..contador
      elemento=elemento[:siguiente]
    end
    return elemento
  end


  #CONDICIONES DE ORDENAMIENTO


  def condicion(nodo,num)
    if num>@lista[:fondo][:valor]
      fondo = @lista[:fondo]
      fondo[:siguiente]=nodo
      @lista[:fondo]=nodo
      @lista[:size]+=1
      @pasoL.push(mostrar_lista())
    elsif num<@lista[:tope][:valor]
      tope = @lista[:tope]
      nodo[:siguiente]=tope
      @lista[:tope]=nodo
      @lista[:size]+=1
      @pasoL.push(mostrar_lista())
    elsif num==@lista[:tope][:valor]
      tope = @lista[:tope]
      nodo[:siguiente]=tope
      @lista[:tope]=nodo
      @lista[:size]+=1
      @pasoL.push(mostrar_lista())
    else
      contador=1
      elemento = @lista[:tope][:siguiente]
      for i in 1..@lista[:size]
        if num<elemento[:valor] || num==elemento[:valor]
          i = @lista[:size]+1
        else
          elemento=elemento[:siguiente]
          contador+=1
        end
      end
      nodo_anterior=obtener_anterior(contador-1)
      nodo_anterior[:siguiente]=nodo
      nodo[:siguiente]=elemento
      @lista[:size]+=1
      @pasoL.push(mostrar_lista())
  end
end

#ORDENAR LISTA


      def ordenar_lista(array=[])
        size = array.size
        for i in 0..size-1
          @pasoL.push("INGRESE: #{array[i]}")
          nodo ={
            valor: array[i],
            siguiente: nil
          }
          if @lista[:esta_vacia]
            @lista[:tope]=nodo
            @lista[:fondo]=nodo
            @lista[:esta_vacia]=false
            @lista[:size]+=1
            @pasoL.push(mostrar_lista())
          else
              condicion(nodo,array[i])

          end
        end
      end

      #MOSTRAR LISTA ORDENADA

      def mostrar_lista
          elemento=@lista[:tope]
            @cadenaL=""
            if elemento ==nil
              @cadenaL=""
              @cadenaL
            elsif elemento[:siguiente]==nil
                @cadenaL+="#{elemento[:valor]}"
                @cadenaL
            else
                @cadenaL+="#{elemento[:valor]}"
                begin
                    elemento = elemento[:siguiente]
                    @cadenaL+=" --> #{elemento[:valor]}"
                end while elemento[:siguiente]!=nil
              @cadenaL
            end
        end


        #MOSTRAR LISTA EN LA TABLA


        def mostrar_tabla(array_anterior)
  tabla = Terminal::Table.new do |a|
  a.title= 'ORDENAR LISTA'
  a.headings = [{value:array_anterior, alignment: :center}]
  a.add_row([{value:mostrar_lista(), alignment: :center}])
  end
  puts tabla
      end

      #MOSTRAR PASOS EN LA TABLA

      def tabla_pasos(contador,array_anterior)
        aux=0
  tabla = Terminal::Table.new do |a|
  a.title= "ELEMENTOS A ORDENAR: #{array_anterior}"
  a.headings = [{value:'DATO', alignment: :center},{value:'ESTRUCTURA', alignment: :center}]
  for i in 0..contador-1
  a.add_row([
  aux+=1,
  @pasoL[i]
  ])
end
  end
  return tabla
      end


      #MOSTRAR PASO A PASO


      def mostrar_paso(array_anterior)
          size=@pasoL.size
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

        def pasos_lista
        size = @pasoL.size
        return size
      end

      def limpiar_lista
        @lista[:tope]=nil
        @lista[:fondo]=nil
        @lista[:size]=0
        @lista[:esta_vacia]=true
        @pasoL.clear
      end
end

