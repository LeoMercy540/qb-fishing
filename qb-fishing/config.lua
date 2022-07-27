Config = {}

Config.fishingitems = {
    label = "Fishing Shop",
        slots = 3,--slots must be same number as amount of items below
        items = {
            [1] = {
                name = "fishingbait",
                price = 100,
                amount = 50,
                info = {},
                type = "item",
                slot = 1,
            },
            [2] = {
                name = "fishingrod",
                price = 1000,
                amount = 500,
                info = {},
                type = "item",
                slot = 2,
            },
        }
    }