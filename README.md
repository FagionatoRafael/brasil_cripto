# 📱 BrasilCripto App

Aplicativo Flutter para **busca e visualização de criptomoedas**, com integração à API da [CoinGecko](https://www.coingecko.com/) e exibição de gráficos de preço.

---

## 🔍 Funcionalidades

- 🔎 Buscar criptomoedas por nome
- ⭐ Marcar/desmarcar moedas como favoritas
- 📊 Visualizar gráfico de variação de preço (últimos 7 dias)
- 💵 Exibir preço atual e volume de mercado
- ⚙️ Interface moderna com gerenciamento de estado via `Provider`

---

## 🧱 Arquitetura

- Arquitetura **MVVM** (Model-View-ViewModel)
- Princípios **SOLID** aplicados na estrutura de camadas
- Uso de padrões de projeto como:
    - **Factory** (instanciamento dos modelos)
    - **Observer** (reação da UI às mudanças de estado)
- Separação de responsabilidades clara: lógica de negócio, UI e dados

---

## 💻 Tecnologias Utilizadas

| Tecnologia  | Uso |
|-------------|-----|
| [Flutter](https://flutter.dev) | Construção da interface |
| [Provider](https://pub.dev/packages/provider) | Gerenciamento de estado |
| [http](https://pub.dev/packages/http) | Comunicação com API |
| [fl_chart](https://pub.dev/packages/fl_chart) | Renderização de gráficos |