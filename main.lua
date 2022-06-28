--bot para telegram portugues brasil
--autor: @techo_pc
--versão: 1.2

--configs para o bot
local debug_mode = false --controla mensagems de debug pode ser alterado usando o comando /debug_mode_true ou /debug_mode_false
Admin_id = 123456789  --seu id
local bot_token = "123456789:AABBCCDDEEFFGGHHII123456789" --token do bot
local url_path = "https://api.telegram.org/bot"..bot_token.."/" --url para request


print("Carregando Modulos")
local http = require("socket.http")
local socket = require("socket")
local lunajson = require("lunajson")



-- lista de addons
print("Carregando Arquivos locais")
local addon_commands = require("commands")

print("Carregamento Pronto")


function sleep(sec)
  socket.select(nil, nil, sec)
end

sleep(0.2)


function get_update(offset)
  --checa se offset é nulo
  if offset == nil then
    offset = 0
  end
  --getupdate
  print("request enviado")
  local response = http.request(url_path .. "getUpdates?offset=" .. offset .. "&parse_mode=MarkdownV2&limit=1&timeout=2&allowed_updates=[“message”}")
  print("request recebido")
  local update = lunajson.decode(response)
  print("request decodificado")

  if update.result[1] == nil then
    print("update vazio")
    return nil
  else
    print("update valido")
    local update_id = update.result[1].update_id
    if update.result[1].message == nil then
      clear_old_request(update_id)
      print("Limpando Request atual para não gerar erro")
    else
      local message = update.result[1].message
      local chat_id = message.chat.id
      local text = message.text
      local user_id = message.from.id
      --retorna os dados
      return update_id, chat_id, text, user_id
    end   
  end
end


--limpa requests antigas
function clear_old_request(update_id)
  print("limpando request antiga")
  local offset = update_id + 1
  get_update(offset)
end

--envia mensagem
function send_message(chat_id, msg)
  msg = string.gsub(msg, " ", "+")
  local url = url_path .. "sendMessage?chat_id=" .. chat_id .. "&text=" .. msg
  http.request(url)
end



--função de debug
function debug_mensages(update_id,chat_id,text,user_id)
  if text == "/debug_mode_true" and Admin_id == user_id then
    debug_mode = true
    send_message(chat_id, "DebugMode Abilitado")
    print("DebugMode Abilitado")
  elseif text == "/debug_mode_false" and Admin_id == user_id then
    debug_mode = false
    send_message(chat_id, "DebugMode Desabilitado")
    print("DebugMode Desabilitado")
  end
  if debug_mode == true then
  send_message(chat_id, "update_id ="..update_id)
  send_message(chat_id, "chat_id ="..chat_id)
  send_message(chat_id, "text ="..text)
  send_message(chat_id, "user_id ="..user_id)
  print("update_id ="..update_id)
  print("chat_id ="..chat_id)
  print("text ="..text)
  print("user_id ="..user_id)
  end
end

--recarregar a lista de comandos
function reload_addons(text, chat_id, user_id)
  if text == "/reload" and Admin_id == user_id then
    send_message(chat_id, "Recarregando comandos")
    package.loaded.commands = nil
    addon_commands = require("commands")
    print("Recarregando comandos")

    local file = io.open("comandslist.txt", "r")
    local str = file:read("*a")
    Chat_commands = Split(str,",")
    file:close()
    
    else
   send_message(chat_id, "voce não pode ultilizar esse comando")
  end
end


local i = 0

--loop de execucao
print("Iniciando Loop Principal")
while true do
  --contador de loop
  i = i + 1
  os.execute("clear")
  print("loop = " .. i)

  --get update
  local update_id, chat_id, text, user_id = get_update()

  sleep(2)
  --checa por comandos se o update não for nulo
  if update_id ~= nil then
    print("Update Valida")
    print("executando comando")
    if text == "/reload" then
      reload_addons(text, chat_id, user_id)
    end
    addon_commands.commands(text, chat_id, user_id, Admin_id)
    new_chat_command(text, chat_id, user_id, Admin_id, update_id)
    

    --mostra algumas informaçoes para debug
    debug_mensages(update_id,chat_id,text,user_id)
    --limpa request antiga
    clear_old_request(update_id)
    sleep(0.2)
  end
  
  sleep(0.2)
end
