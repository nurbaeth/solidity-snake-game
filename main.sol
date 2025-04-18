// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract SnakeGame {
    enum Direction { Up, Down, Left, Right }
    enum GameState { Playing, GameOver }

    struct Position {
        uint8 x;
        uint8 y;
    }

    struct Game {
        Position[] snake;
        Position food;
        Direction dir;
        GameState state;
        uint256 score;
    }

    mapping(address => Game) public games;
    uint8 constant WIDTH = 10;
    uint8 constant HEIGHT = 10;

    function startGame() external {
        Position ;
        initial[0] = Position(5, 5);

        games[msg.sender] = Game({
            snake: initial,
            food: _randomFood(),
            dir: Direction.Right,
            state: GameState.Playing,
            score: 0
        });
    }

    function move(Direction newDir) external {
        Game storage game = games[msg.sender];
        require(game.state == GameState.Playing, "Game over");

        if (_isOpposite(game.dir, newDir)) {
            newDir = game.dir;
        }
        game.dir = newDir;

        Position memory head = game.snake[game.snake.length - 1];
        Position memory next = _nextPosition(head, newDir);

        if (_isCollision(game.snake, next)) {
            game.state = GameState.GameOver;
            return;
        }

        game.snake.push(next);

        if (next.x == game.food.x && next.y == game.food.y) {
            game.score++;
            game.food = _randomFood();
        } else {
            // move: remove tail
            for (uint i = 0; i < game.snake.length - 1; i++) {
                game.snake[i] = game.snake[i + 1];
            }
            game.snake.pop();
        }
    }

    function getGame() external view returns (
        Position[] memory,
        Position memory,
        Direction,
        GameState,
        uint256
    ) {
        Game storage g = games[msg.sender];
        return (g.snake, g.food, g.dir, g.state, g.score);
    }

    // ----------- Internal logic -----------

    function _nextPosition(Position memory pos, Direction dir) internal pure returns (Position memory) {
        if (dir == Direction.Up && pos.y > 0) return Position(pos.x, pos.y - 1);
        if (dir == Direction.Down && pos.y < HEIGHT - 1) return Position(pos.x, pos.y + 1);
        if (dir == Direction.Left && pos.x > 0) return Position(pos.x - 1, pos.y);
        if (dir == Direction.Right && pos.x < WIDTH - 1) return Position(pos.x + 1, pos.y);
        return pos; // bump into wall: collision
    }

    function _isCollision(Position[] memory snake, Position memory next) internal pure returns (bool) {
        for (uint i = 0; i < snake.length; i++) {
            if (snake[i].x == next.x && snake[i].y == next.y) {
                return true; // collision with itself
            }
        }
        return false;
    }

    function _isOpposite(Direction current, Direction newDir) internal pure returns (bool) {
        return (current == Direction.Up && newDir == Direction.Down) ||
               (current == Direction.Down && newDir == Direction.Up) ||
               (current == Direction.Left && newDir == Direction.Right) ||
               (current == Direction.Right && newDir == Direction.Left);
    }

    function _randomFood() internal view returns (Position memory) {
        // Not secure randomness — just for game logic
        uint256 randX = uint256(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, msg.sender))) % WIDTH;
        uint256 randY = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, blockhash(block.number - 1)))) % HEIGHT;
        return Position(uint8(randX), uint8(randY));
    }
}
