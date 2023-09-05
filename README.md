# Github Search 🔎

O aplicativo tem como objetivo mostrar usuários do github e suas informações. 

<div align="center">
<img src="/assets/empty.png" alt="empty" style="height: 450px; "/>
<img src="/assets/search.png" alt="search" style="height: 450px; "/>
<img src="/assets/profile.png" alt="profile" style="height: 450px; "/>
<img src="/assets/history.png" alt="history" style="height: 450px; "/>
</div>

### Testes de unidade

Nos testes de unidade foi utilizando o [Mocktail](https://pub.dev/packages/mocktail), biblioteca de teste que fornece uma sintaxe simples para criar mocks.


## Detalhes Técnicos

### API
O aplicativo foi viabilizado utilizada a API [Fake Store](https://api.github.com).

### Arquitetura

O aplicativo foi desenvolvido utilizando Clean Architecture. 

### Gerenciamento de estado
Como gerenciamento de estado foi utilizado ValueNotifier com StatePattern, para que o estado seja notificado apenas quando houver alteração.
