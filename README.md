# 🏨 EasyBooking

Sistema de gerenciamento de hospedagens desenvolvido com Flutter e Supabase, permitindo autenticação de usuários e gerenciamento completo de hospedagens através de operações CRUD.

---

## 🚀 Sobre o Projeto

O **EasyBooking** é uma aplicação mobile/web criada para simular uma plataforma simples de gerenciamento de hospedagens.
O sistema permite que usuários criem uma conta, realizem login e gerenciem hospedagens cadastradas em tempo real.

O projeto foi desenvolvido utilizando:

* Flutter
* Dart
* Supabase Authentication
* Supabase Database
* Material Design 3

---

# ✨ Funcionalidades

✅ Cadastro de usuários
✅ Login e Logout
✅ Proteção de telas autenticadas
✅ CRUD completo de hospedagens
✅ Atualização em tempo real com Supabase
✅ Interface moderna e responsiva
✅ Validação de formulários
✅ Feedback visual com SnackBars e Loadings

---

# 📱 Telas do Sistema

* Login
* Cadastro
* Home de Hospedagens
* Modal de criação/edição


---

# 🧠 Arquitetura do Projeto

```bash
/lib
 ├── main.dart
 ├── /screens
 │    ├── login_screen.dart
 │    ├── register_screen.dart
 │    └── home_screen.dart
 │
 ├── /services
 │    ├── auth_service.dart
 │    └── database_service.dart
 │
 ├── /models
 │    └── models.dart
```

---

# 🔐 Autenticação

A autenticação é realizada utilizando o **Supabase Authentication** com login via:

* E-mail
* Senha

O sistema controla:

* Sessão ativa
* Login
* Cadastro
* Logout
* Proteção de acesso às telas privadas

---

# ▶️ Como Executar o Projeto

## 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/easybooking.git
```

---

## 2. Entre na pasta

```bash
cd easybooking
```

---

## 3. Instale as dependências

```bash
flutter pub get
```

---

## 4. Execute o projeto

```bash
flutter run
```

---

# ⚙️ Configuração do Supabase

No arquivo `main.dart`, configure:

```dart
await Supabase.initialize(
  url: 'SUA_URL',
  anonKey: 'SUA_ANON_KEY',
);
```

---

# 🎨 Identidade Visual

O projeto utiliza uma identidade visual moderna baseada em:

* Azul escuro
* Branco
* Componentes arredondados
* Cards elegantes
* Material Design 3

---

# 📌 Objetivo Acadêmico

Este projeto foi desenvolvido como atividade prática acadêmica com foco em:

* Flutter
* Integração com Back-end
* Autenticação
* CRUD
* Boas práticas de arquitetura

---

# 👨‍💻 Desenvolvedor

Projeto desenvolvido por **Arthur Stopa Oliveira e Mayan Santos do Nascimento**.

---
