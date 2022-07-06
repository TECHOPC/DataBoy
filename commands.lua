local addon_commands = {}


--lista de comandos

function start(chat_id , text)
  if text == "/start" then
    send_message(chat_id, "olá sou o Gambiarrinha, use /help para saber oque eu posso fazer")
    print("Comando Start")
  end
end

function help(text, chat_id)
  if text == "/help" then
    send_message(chat_id, "esses são os comandos que eu entendo /start , /help , /list_commands")
    print("Comando Test")
  end 
end


--funcççao que permite criar novos comando pelo chat
function new_chat_command(text, chat_id, user_id, Admin_id, update_id)
  if text == "/new_command" and user_id == Admin_id then
    print("criando novo comando")
    send_message(chat_id, "Vamos criar um novo comando.")
    send_message(chat_id, "Qual vai sero novo comando?(use o formato /NOVOCOMANDOAQUI)")
    clear_old_request(update_id)
    local looping = true
    while looping == true do
      sleep(5)
      update_id, chat_id, text, user_id = get_update()
      print("request comando")
      if get_update() ~= nil and text ~= nil and user_id == Admin_id then
        looping = false
        print("looping = false")

      else
        looping = true
        print("looping = true")
        
      end
    end
    if text ~= nil and user_id == Admin_id then
      New_command = text
      print("novo comando recebido")
      send_message(chat_id, "ok, agora, oque eu devo responder quando receber.")
      send_message(chat_id, "use /R RESPOSTADOCOMANDO")



    clear_old_request(update_id)
    local looping = true
    while looping == true do
      sleep(5)
      update_id, chat_id, text, user_id = get_update()
      print("request resposta")
      if get_update() ~= nil and text ~= nil and user_id == Admin_id then
        looping = false
        print("looping = false")
        
      else
        looping = true
        print("looping = true")
        
      end
    end

        update_id, chat_id, text, user_id = get_update()
      if text ~= nil and user_id == Admin_id then
        New_response = string.gsub(text,"/R "," ")
        print("nova resposta recebida")
        send_message(chat_id, "ok, salvando...")
        file = io.open("comandslist.txt", "a")
        file:write(New_command..",")
        file:write(New_response.." ,")
        file:close()
        print("comando salvo")
        send_message(chat_id, "ok, salvo")
        send_message(chat_id, "Use o comando /reload para recaregar")
      end      
    end
  end
end

-- função que permite remover comandos pelo chat
function remove_chat_command(text, chat_id, user_id, Admin_id)
  if text == "/remove_command" and user_id == Admin_id then
    send_message(chat_id, "Qual comando deseja remover?")

    local update_id = get_update()
    clear_old_request(update_id)
    local looping = true
    while looping == true do
      sleep(5)
      update_id, chat_id, text, user_id = get_update()
      print("request comando")
      if get_update() ~= nil and text ~= nil and user_id == Admin_id then
        looping = false
        print("looping = false")

      else
        looping = true
        print("looping = true")
        
      end
    end
    if text ~= nil and user_id == Admin_id then
      for i=1,#Chat_commands do
        if text == Chat_commands[i] then
          table.remove(Chat_commands,i)
          table.remove(Chat_commands,i)
          file = io.open("comandslist.txt","w")
          file:write(table.concat( Chat_commands, ",", 1, #Chat_commands ))
          file:close()
          send_message(chat_id,"comando removido")
          break
        end
      end
    end
        

  end
  
end

-- funcção para listar os comandos criados pelo chat
function list_chat_commands(text, chat_id)
  if text == "/list_commands" then
    send_message(chat_id, "Essa é a lista de comandos:")
    send_message(chat_id, "Comandos padrão")
    send_message(chat_id, "/start /help /new_command (apenas admin)")
    send_message(chat_id, "/list_commands (aperesse essa lista)")
    send_message(chat_id, "Comandos personalizados (Adicionados pelo chat)")
    local listcommands = {}
    local i = 1
    while i<#Chat_commands  do
      table.insert(listcommands,table.concat(Chat_commands,",",i,i))
      i = i+2
    end
    send_message(chat_id, table.concat(listcommands,",",1,#listcommands))
  end
end

-- função para chamar os comandos criados pelo chat
function Call_chat_commands(chat_id, text)
  for i=1, #Chat_commands do
    if Chat_commands[i] == text then
      local msg = table.concat( Chat_commands, ",", i+1,i+1)
      send_message(chat_id, msg)
    end
  end
end


--chama todos os comandos

function addon_commands.commands(text, chat_id,user_id, Admin_id) 
  start(chat_id , text)
  help(text, chat_id)
  new_chat_command()
  Call_chat_commands(chat_id, text)
  remove_chat_command(text, chat_id, user_id, Admin_id)
  list_chat_commands(text, chat_id)

end


return addon_commands