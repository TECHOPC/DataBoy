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
    send_message(chat_id, "esses são os comandos que eu entendo /start , /help , /echo , /test")
    print("Comando Test")
  end 
end

function echo(text, chat_id)
  if text == "/echo" then
    send_message(chat_id, "echo...echo...echo...")
    print("Comando Echo")
  end
end

function test(chat_id, text)
  if text == "/test" then
    send_message(chat_id, "testando 1 2 3 testando")
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
        file:write(New_response..",")
        file:close()
        print("comando salvo")
        send_message(chat_id, "ok, salvo")
        send_message(chat_id, "Use o comando /reload para recaregar")

      end      
    end
  end
end

function Split(s, delimiter)
  local result = {};
  for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      table.insert(result, match);
  end
  return result;
end

function Reload_chat_commands(text, user_id, Admin_id)
  if text == "/reload_chat_commands" and user_id == Admin_id then
  end
end


-- função para chamar os comandos criados pelo chat
function Call_chat_commands(chat_id, text)
  for i=1, #Chat_commands do
    if Chat_commands[i] == text then
      send_message(chat_id, table.concat( Chat_commands, ", ", i+1))
    end
  end
end


--chama todos os comandos

function addon_commands.commands(text, chat_id,user_id, Admin_id) 
  echo(text, chat_id)
  test(chat_id, text)
  start(chat_id , text)
  help(text, chat_id)
  new_chat_command()
  Call_chat_commands(chat_id, text)

end


return addon_commands