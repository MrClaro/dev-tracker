# DevTracker 📚

Aplicativo mobile desenvolvido em Flutter para estudantes de TI registrarem e acompanharem suas sessões de estudo de programação.

Projeto prático da disciplina **Desenvolvimento para Dispositivos Móveis**.

---

## Funcionalidades

- **Perfil do usuário** com foto, nome, RA e conquistas
- **Registro de sessões** de estudo por tecnologia/linguagem
- **Totalizador de horas** estudadas atualizado em tempo real
- **Histórico** de sessões com horário registrado
- **Tela de detalhes** de cada sessão ao clicar no histórico

---

## Telas

| Perfil | Registro | Detalhes |
|--------|----------|----------|
| Banner com foto sobreposta, conquistas e informações do aluno | Card totalizador, campos de entrada e lista de sessões | Exibe tecnologia e horas da sessão selecionada |

---

## Tecnologias e conceitos utilizados

- Flutter + Dart
- `StatelessWidget` e `StatefulWidget`
- `BottomNavigationBar` + `IndexedStack`
- `Stack` + `Positioned`
- `ListView.builder` + `Expanded`
- `Navigator.push` / `Navigator.pop`
- Gerenciamento de estado com `setState`

---

## Estrutura do projeto

```
lib/
├── main.dart                  # Entrada do app e navegação principal
└── screens/
    ├── perfil_screen.dart     # Aba de perfil (StatelessWidget)
    ├── estudos_screen.dart    # Aba de registro (StatefulWidget)
    └── detalhe_screen.dart    # Tela de detalhes da sessão
```

---

## Como executar

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/devtracker.git

# Entre na pasta
cd devtracker

# Instale as dependências
flutter pub get

# Execute o app
flutter run
```
