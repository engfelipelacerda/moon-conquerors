# Moon Conquerors

Projeto desenvolvido para o Trabalho Prático 2 da disciplina de Computação Gráfica da Universidade Federal do Ceará (UFC) - Campus Sobral.

## Integrantes

- Ruan Pereira
- Luis Felipe
- Pedro Rickson
- Lucas Vieira

---

# Sobre o Jogo

Moon Conquerors é um jogo de ação e sobrevivência 2D ambientado na superfície da Lua.

O jogador controla um explorador lunar que deve sobreviver ao ataque constante de naves inimigas enquanto atravessa o terreno lunar e elimina ameaças utilizando seu armamento.

O projeto foi desenvolvido utilizando a engine Godot 4.7 e busca aplicar conceitos de Computação Gráfica através da movimentação de objetos, colisões, animações, transformações espaciais e sistemas de câmera.

---

# Tema da Game Jam

## Movimento

O tema "Movimento" está presente em diversos aspectos do jogo:

- Movimentação horizontal do jogador.
- Sistema de pulo.
- Movimento dinâmico dos inimigos.
- Rotação das naves durante o deslocamento.
- Movimento dos projéteis.
- Perseguição automática do jogador pelos inimigos.
- Navegação dos inimigos utilizando comportamento de steering.

---

# Objetivo

Sobreviver ao maior tempo possível derrotando as naves inimigas e evitando ser atingido pelos disparos adversários.

---

# Mecânicas

## Jogador

- Movimentação lateral.
- Pulo.
- Sistema de tiro.
- Sistema de vida.
- Colisão com projéteis inimigos.

## Inimigos

- Movimento aéreo.
- Perseguição do jogador.
- Rotação automática baseada na direção do movimento.
- Disparo automático quando o jogador entra no alcance.
- Sistema de vida.

## Combate

- Balas do jogador.
- Balas inimigas.
- Sistema de dano.
- Detecção de colisão.
- Eliminação de inimigos.

---

# Tecnologias Utilizadas

- Godot Engine 4.7
- GDScript
- OpenGL Compatibility Renderer

---

# Estrutura do Projeto

```text
moon-conquerors/
│
├── entities/
│   ├── Player
│   ├── Enemy
│   ├── Bullet
│   └── EnemyBullet
│
├── scenes/
│
├── scripts/
│
├── sprites/
│
├── tiles/
│
├── project.godot
│
└── README.md
```

---

# Como Executar

## Abrindo no Godot

1. Instale o Godot 4.7.
2. Abra o projeto.
3. Execute o projeto pressionando:

```text
F5
```

4. Ou rode pelo executável do jogo para seu respectivo SO.

---

# Aplicação de Computação Gráfica

O projeto utiliza diversos conceitos abordados na disciplina:

## Transformações Espaciais

- Translação de personagens.
- Movimentação de projéteis.
- Rotação dos inimigos.

## Animação

- AnimatedSprite2D.
- Troca de estados visuais.

## Colisões

- Area2D.
- CharacterBody2D.
- CollisionShape2D.

## Renderização

- Sprites 2D.
- Pixel Art.
- Composição de cenário.

## Sistema de Câmera

- Acompanhamento do jogador.
- Navegação pelo cenário.

---

# Funcionalidades Implementadas

- Sistema de movimentação.
- Sistema de pulo.
- Sistema de tiro.
- Sistema de dano.
- Sistema de vida.
- IA de perseguição.
- IA de ataque.
- Balas do jogador.
- Balas inimigas.
- Colisões.
- Animações.
- Cenário lunar.

---

# Considerações Finais

Moon Conquerors foi desenvolvido com o objetivo de explorar os conceitos de Computação Gráfica apresentados na disciplina, aplicando-os em um jogo funcional que incorpora o tema "Movimento" através da interação entre jogador, inimigos e ambiente.
