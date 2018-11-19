require 'rubygems'
require 'terminal-table'
require_relative 'ordenarpila'
require_relative 'ordenarcola'
require_relative 'ordenarlista'

def limpiar_pantalla
    system('clear')
end

ordenamientof={
    ordenar: false
}
pila = Pila.new
cola = Cola.new
lista = Lista.new
array =[]

#PORCENTAJE DE RENDIMIENTO

def rendimientof(pila,cola,lista)
  array=[]
  pila_1=pila.pasos_pila()
  cola_1=cola.pasos_cola()
  lista_1=lista.pasos_lista()
  if pila_1>cola_1 && pila_1>lista_1
    rendi_pila= 100
    rendi_cola = (pila_1/(cola_1*1.00))*100
    rendi_lista = (pila_1/(lista_1*1.00))*100
    array.push(rendi_pila)
    array.push(rendi_cola)
    array.push(rendi_lista)
  elsif cola_1>pila_1 && cola_1>lista_1
    rendi_pila= (cola_1/(pila_1*1.00))*100
    rendi_cola = 100
    rendi_lista = (cola_1/(lista_1*1.00))*100
    array.push(rendi_pila)
    array.push(rendi_cola)
    array.push(rendi_lista)
  elsif lista_1>cola_1 && lista_1>pila_1
     rendi_pila= (lista_1/(pila_1*1.00))*100
    rendi_cola = (lista_1/(cola_1*1.00))*100
    rendi_lista = 100
    array.push(rendi_pila)
    array.push(rendi_cola)
    array.push(rendi_lista)
  end
  return array
end

#INGRESAR DATOS

def ingreso_de_datos(array=[],ordenamientof,pila,cola,lista)
  if ordenamientof[:ordenar]
    array.clear
    print 'INGRESE LOS NUMEROS SEPARADOS POR UNA COMA (,) '
    cadena = gets.chomp
    cadena1 = cadena.split(',')
    cadena1.each do |x|
    array.push(x)
  end
  size=array.size
  for i in 0..size-1
    array[i] = array[i].to_i
  end
  ordenamientof[:ordenar]=false
    pila.limpiar_pila()
    cola.limpiar_cola()
    lista.limpiar_lista()
else
    print 'INGRESE LOS NUMEROS SEPARADOS POR UNA COMA (,) '
    cadena = gets.chomp
    cadena1 = cadena.split(',')
    cadena1.each do |x|
    array.push(x)
  end
  size=array.size
  for i in 0..size-1
    array[i] = array[i].to_i
  end
  gets
end
end

#TABLA ORDEN DE TODOS LOS DATOS

def ordenar_todos_los_datos(pila,array=[],cola,lista,ordenamientof)
  if ordenamientof[:ordenar]
    array_anterior=array.join(',')
    array_rendi = rendimientof(pila,cola,lista)
    tabla = Terminal::Table.new do |a|
  a.title= "ORDENAR TODO #{array_anterior} "
  a.headings = [{value:'PASOS', alignment: :center},{value:'ESTRUCTURA', alignment: :center},{value:'% RENDIMIENTO', alignment: :center},{value:'Ordenada', alignment: :center}]
  a.add_row([pila.pasos_pila(),{value:'PILA', alignment: :center},{value:array_rendi[0], alignment: :center},pila.mostrar_pila()])
  a.add_row([cola.pasos_cola(),{value:'COLA', alignment: :center},{value:array_rendi[1], alignment: :center},cola.mostrar_cola()])
  a.add_row([lista.pasos_lista(),{value:'KISTA', alignment: :center},{value:array_rendi[2], alignment: :center},lista.mostrar_lista()])
  end
  puts tabla
  gets
else
    array_anterior=array.join(',')
    pila.ordenar_pila(array)
    cola.ordenar_cola(array)
    lista.ordenar_lista(array)
    array_rendi = rendimientof(pila,cola,lista)
  tabla = Terminal::Table.new do |a|
  a.title= "ORDENAR TODO #{array_anterior} "
  a.headings = [{value:'N. PASOS', alignment: :center},{value:'ESTRUCTURA', alignment: :center},{value:'% RENDIMIENTO', alignment: :center},{value:'Ordenada', alignment: :center}]
  a.add_row([pila.pasos_pila(),{value:'PILA', alignment: :center},{value:array_rendi[0], alignment: :center},pila.mostrar_pila()])
  a.add_row([cola.pasos_cola(),{value:'COLA', alignment: :center},{value:array_rendi[1], alignment: :center},cola.mostrar_cola()])
  a.add_row([lista.pasos_lista(),{value:'LISTA', alignment: :center},{value:array_rendi[2], alignment: :center},lista.mostrar_lista()])
  end
  puts tabla
  ordenamientof[:ordenar]=true
  gets
end
end


#MENU ORDEN PASO A PASO

def ordenar_paso_a_paso(pila,array=[],cola,lista,ordenamientof)
  if ordenamientof[:ordenar]
  begin
    limpiar_pantalla
  tabla = Terminal::Table.new do |a|
  a.title= 'ORDEN PASO A PASO'
  a.headings = [{value:'No.', alignment: :center},{value:'ESTRUCTURA', alignment: :center}]
  a.add_row([{value:'1', alignment: :center},'COLA' ])
  a.add_row([{value:'2', alignment: :center},'PILA'])
  a.add_row([{value:'3', alignment: :center},'LISTA'])
  a.add_row([{value:'4', alignment: :center},'SALIR' ])
end
  puts tabla
  print "INGRESE UNA ESTRUCTURA "
  opc = gets.chomp
  limpiar_pantalla()
  
  if opc == '1'
    if array.size!=0
      array_anterior=array.join(',')
      cola.mostrar_paso(array_anterior)
      gets
    else
    puts 'INGRESE DATOS A ORDENAR'
    gets
    end
elsif opc == '2'
    if array.size!=0
      array_anterior=array.join(',')
      pila.mostrar_pasos(array_anterior)
      gets
    else
    puts 'INGRESE DATOS A ORDENAR'
    gets
    end
elsif opc == '3'
    if array.size!=0
      array_anterior=array.join(',')
      lista.mostrar_paso(array_anterior)
      gets
    else
    puts 'INGRESE DATOS A ORDENAR'
    gets
    end
  else
    'OPCION INVALIDA'
    gets
  end
end while opc!='4'
else
    array_anterior=array.join(',')
    pila.ordenar_pila(array)
    cola.ordenar_cola(array)
    lista.ordenar_lista(array)
    ordenamientof[:ordenar]=true
      begin
    limpiar_pantalla
  tabla = Terminal::Table.new do |a|
  a.title= 'ORDEN PASO A PASO'
  a.headings = [{value:'No.', alignment: :center},{value:'ESTRUCTURA', alignment: :center}]

  a.add_row([{value:'1', alignment: :center},'COLA' ])
  a.add_row([{value:'2', alignment: :center},'PILA'])
  a.add_row([{value:'3', alignment: :center},'LISTA'])
  a.add_row([{value:'4', alignment: :center},'SALIR' ])
end
  puts tabla
  print "INGRESE UNA ESTRUCTURA: "
  opc = gets.chomp
  limpiar_pantalla()
  
  if opc == '1'
    if array.size!=0
      array_anterior=array.join(',')
      cola.mostrar_paso(array_anterior)
      gets
    else
    puts 'INGRESE DATOS'
    gets
    end
elsif opc == '2'
    if array.size!=0
      array_anterior=array.join(',')
      pila.mostrar_pasos(array_anterior)
      gets
    else
    puts 'INGRESE DATOS'
    gets
    end
elsif opc == '3'
    if array.size!=0
      array_anterior=array.join(',')
      lista.mostrar_paso(array_anterior)
      gets
    else
    puts 'INGRESE DATOS'
    gets
    end
  else
    'OPCION INVALIDA'
    gets
  end
end while opc!='4'
end
end

#MENU PRINCIPAL


begin
  limpiar_pantalla
  tabla = Terminal::Table.new do |a|
  a.title= 'SEGUNDO PROYECTO'
  a.headings = ['No.',{value:'OPCIONES', alignment: :center}]

  a.add_row([{value:'1', alignment: :center},'INGRESO DATOS' ])
  a.add_row([{value:'2', alignment: :center},'ORDEN POR TODOS LOS METODOS'])
  a.add_row([{value:'3', alignment: :center},'ORDEN PASO A PASO'])
  a.add_row([{value:'4', alignment: :center},'SALIR' ])
end
    

  puts tabla
  print 'INGRESE UNA OPCION '
    opciones = gets.chomp

    limpiar_pantalla()
 
    if opciones == '1'
      ingreso_de_datos(array,ordenamientof,pila,cola,lista)
    elsif opciones == '2'
      ordenar_todos_los_datos(pila,array,cola,lista,ordenamientof)
    elsif opciones == '3'
        ordenar_paso_a_paso(pila,array,cola,lista,ordenamientof)
    elsif opciones == '4'
        puts "SALIO DEL PROGRAMA"
    else
      puts 'OPCION INCORRECTA'
      gets
    end
  end while (opciones!='4')

