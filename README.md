# DataBoy 1.2
bot para telegram

## Requisitos para rodar:
- lua         5.3.5 
- luarocks    3.8.0 
- lunajson    1.2.3-1
- luasocket   3.0.0-1


No arquivo main.lua vai ter campos para colocar seu id de usuario no campo Admin_id e o token do bot em Bot_token.
O bot conta com comandos que são aceitos apenas por quem tem o mesmo id ao Admin_id como:
/reload > recarrega o módulo commands (usado para editar comandos sem ter que reiniciar o main.lua)
/debug_mode_true e /debug_mode_false > liga e desliga algumas mensagens de debug 
Bot ainda em desenvolvimento


### Lista de comandos para usuarios

- /start
- /help
- /test
- /echo

### Lista de comandos para Admin

- /reload
- /debug_mode_true
- /debug_mode_false