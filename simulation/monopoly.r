gameboard <- data.frame(space = 1:40, title = c("Go" , "Mediterranean Avenue" , "Community Chest" , "Baltic Avenue" , "Income Tax" , "Reading Railroad" , "Oriental Avenue" , "Chance" , "Vermont Avenue" , "Connecticut Avenue" , "Jail" , "St. Charles Place" , "Electric Company" , "States Avenue" , "Virginia Avenue" , "Pennsylvania Railroad" , "St. James Place" , "Community Chest" , "Tennessee Avenue" , "New York Avenue" , "Free Parking" , "Kentucky Avenue" , "Chance" , "Indiana Avenue" , "Illinois Avenue" , "B & O Railroad" , "Atlantic Avenue" , "Ventnor Avenue" , "Water Works" , "Marvin Gardens" , "Go to jail" , "Pacific Avenue" , "North Carolina Avenue" , "Community Chest" , "Pennsylvania Avenue" , "Short Line Railroad" , "Chance" , "Park Place" , "Luxury Tax" , "Boardwalk"))

chancedeck <- data.frame(index = 1:15, card = c("Advance to Go" , "Advance to Illinois Ave." , "Advance to St. Charles Place" , "Advance token to nearest Utility" , "Advance token to the nearest Railroad" , "Take a ride on the Reading Railroad" , "Take a walk on the Boardwalk" , "Go to Jail" , "Go Back 3 Spaces" , "Bank pays you dividend of $50" , "Get out of Jail Free" , "Make general repairs on all your property" , "Pay poor tax of $15" , "You have been elected Chairman of the Board" , "Your building loan matures"))

communitydeck <- data.frame(index = 1:16, card = c("Advance to Go" , "Go to Jail" , "Bank error in your favor ??? Collect $200" , "Doctor's fees Pay $50" , "From sale of stock you get $45" , "Get Out of Jail Free" , "Grand Opera Night Opening" , "Xmas Fund matures" , "Income tax refund" , "Life insurance matures ??? Collect $100" , "Pay hospital fees of $100" , "Pay school tax of $150" , "Receive for services $25" , "You are assessed for street repairs" , "You have won second prize in a beauty contest" , "You inherit $100"))

## for chance deck
...
    if(chancedrawn == 1) 
        code changes player position to space 1  # advance to go
    if(chancedrawn == 2) 
        code changes player position to space 25 # advance to Illinois avenue
    if(chancedrawn == 3)
        code changes player position to space 12 # advance to St. Charles Place
    if(chancedrawn == 4)
        code changes player position to space X  # advance to nearest Utility
    if(chancedrawn == 5)
        code chagges player position to space X  # advance to nearest Railroad
    if(chancedrawn == 6)
        code changes player position to space 6  # advance to Reading Railroad
    if(chancedrawn == 7)
        code changes player position to space 40 # advance to Boardwalk
    if(chancedrawn == 8)
        code changes player position to space 11 # advance to Jail
    if(chancedrawn == 9)
        code changes player position to space -3
    if(chancedrawn == 11)
        no move, but with a chance to get out of Jail for free
    else
        no move
...

## for the community deck
...
    if(communitydrawn == 1)
        code changes player position to space 1  # advance to Go
    if(communitydrawn == 2)
        code changes player position to space 11 # advance to Jail
    if(communitydrawn == 6)
        no move, but get a card for free
    else
        no move
...

dice <- function(){
    faces <- sample(1:6, 2, replace=TRUE)
    if(faces[1] == faces[2]) doubles = TRUE
    else doubles = FALSE
    movement = sum(faces)
    return(list(faces=faces, doubles=doubles, movement=movement))
}
