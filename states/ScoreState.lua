--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

-- load the medal images
local bronzeMedal = love.graphics.newImage('bronze_medal.png')
local silverMedal = love.graphics.newImage('silver_medal.png')
local goldMedal = love.graphics.newImage('gold_medal.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score

-- determine which medal to award based on the score
if self.score >= 10 then
    self.medal = goldMedal
elseif self.score >= 5 then
    self.medal = silverMedal
elseif self.score >= 1 then
    self.medal = bronzeMedal
else
    self.medal = nil
end
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

-- render the medal if the player earned one
    if self.medal then
        love.graphics.draw(self.medal, (VIRTUAL_WIDTH / 2) - (self.medal:getWidth() / 2), 120)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 160 + mediumFont:getHeight(), VIRTUAL_WIDTH, 'center')
end