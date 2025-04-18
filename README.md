# 🐍 Snake Game on Solidity

This is a fully on-chain Snake game built in Solidity — every move, every bite, every crash happens on the blockchain.

---

## 🎮 How It Works

Each player has their own game state. You can:

- 🟢 Start a new game
- 🔁 Move in four directions
- 🍎 Eat randomly placed food
- 🧱 Die if you hit yourself or the wall

All game logic is handled inside the smart contract — **no frontend or off-chain logic needed.**

---

## 📦 Features

- 🔄 Fully on-chain logic  
- 👤 Individual game per address  
- 📈 Auto-growing snake after eating food  
- 🧠 Simple AI-style collision checks  
- 🎲 Pseudo-random food spawn

---

## 🧪 Play in Remix

1. Open [Remix IDE](https://remix.ethereum.org/)
2. Paste `SnakeGame.sol` into a new file
3. Compile using Solidity `0.8.x`
4. Deploy `SnakeGame` in JavaScript VM
5. Use the following functions:

| Function        | Description |
|----------------|-------------|
| `startGame()`  | Starts a new game |
| `move(uint)`   | Move the snake:<br>0 = Up, 1 = Down, 2 = Left, 3 = Right |
| `getGame()`    | Returns full game state:<br>snake body, food, direction, status, score |

---

## 🧩 Example

```solidity
// Start game
startGame()

// Move right
move(3)

// Move down
move(1)

// Get current state
getGame()
