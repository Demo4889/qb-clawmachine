Config = {
    machines = { -- Add as many claw machines as you want. They are all run off qb-target
        [1] = {
            location = vector4(116.88, -1568.91, 29.6, 226.96), -- Must be a vector4 to set the heading of the machine. Machine will face the way you are facing
            prizechance = 50, -- chance player will get a prize
            payaccount = "cash", --Set to "cash" or "bank" depending on what you want the player to pay as
            prizes = { -- Add as many prizes as you want
                'funkopop_harrypotter',
                'funkopop_hermione',
            }
        },
        [2] = {
            location = vector4(115.19, -1570.59, 29.6, 230.98), -- Must be a vector4 to set the heading of the machine. Machine will face the way you are facing
            prizechance = 50, -- chance player will get a prize
            payaccount = "cash", --Set to "cash" or "bank" depending on what you want the player to pay as
            prizes = { -- Add as many prizes as you want
                'funkopop_draco',
                'funkopop_ron',
            }
        }
    },

    price = 1
}

Config.Text = { -- Convert text to your own language
    ['claw_machine'] = 'Claw Machine',
    ['use_claw'] = 'Use Claw Machine $',
    ['grab_toy'] = 'Working Joystick...',
    ['ate_money'] = 'The machine ate your money...'
}