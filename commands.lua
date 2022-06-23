local addon_commands = {}

--lista de comandos

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

--chama todos os comandos

function addon_commands.commands(text, chat_id,user_id) 
  echo(text, chat_id)
  test(chat_id, text)
  start(chat_id , text)
  help(text, chat_id)
end


return addon_commands

--[[

local channelID = "UCMBSKO1nn-uXBwn9Sy_reDw"
local publishedAfter = "2022-06-10T00%3A00%3A00.0%2B03%3A00"
local publishedBefore = "2022-06-22T00%3A00%3A00.0%2B03%3A00"
keyAPI = "AIzaSyAvq7XhABBBqitq91lapg4PV7m6akdBwFQ"


local urlytpath = "https://youtube.googleapis.com/youtube/v3/activities?part=contentDetails&channelId="..channelID.."&maxResults=1&publishedAfter="..publishedAfter.."&publishedBefore="..publishedBefore.."&key="..keyAPI.." HTTP/1.1"

]]