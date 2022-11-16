/*
Notes:
Group Discussion 
What does a story include? and what makes it interesting? 
    - list of characters
    - types of stories (general plot)
    - actions for the characters to do
    - the charcters have relationship with each other
    - the environment the characters are in allows for overlap 
    - major conflict

Making up our Mystery Story:
    Characters:
        1. Victim 
        2. Hero
        3. Suspect  
        Character Relations;
            - characters all fall into one of the above catagories 
            - all villians are related to the victim in some way

    Setting:
        - incorperate overlapping layers so that certain queries can result in
            both the hero/victim/suspect being associated with a place
                ex. the victim and hero live in the same house
    
    Genral Plot:
        - verbs that apply to areas of the setting 
            ex. attending certain events/being in the same place at the same time

    Major Conflict:
        - the suspects are all capable of doing something to a victim but not
            all suspects commited crimes   
*/

% Facts
suspect(emilie).
suspect(evan).
hero(crystal).
is_dead(john).
wife(emilie).
leaves_weapon(evan).
napping(emilie).
friends(emilie, crystal, john).
at_home(john).
at_home(emilie).
is_related(john, evan).
looks_guilty(emilie).
owns_weapon(evan).
owns_weapon(john).
owns_weapon(emilie).
cooking(crystal).

%Rules of Major Conflict 
% #1: if left their weapon, or is a suspect with access to weapon, and was in room, they are the murderer
murder(X) :-
    leaves_weapon(X); suspect(X), access_to_weapon(X), in_room(X).

% #2: Anyone who owns a weapon, was at home, or looks guilty has access to weapon
access_to_weapon(X):-
    owns_weapon(X); at_home(X); looks_guilty(emilie).

% #3: Any one who is napping or cooking, or not at home is busy.
busy(X) :-
    napping(X); cooking(X); \+at_home(X).

% #4: You have an alibi if you are busy or if dead.
has_alibi(X) :-
    busy(X); victim(X).

% #5: The hero suspects anyone in the room or who leaves a weapon
hero_suspects(X) :- 
    in_room(X); access_to_weapon(X).

% #6: Anyone at home who wasn't napping or cooking, 
in_room(X) :- 
    at_home(X), \+busy(X).

% #7: Anyone at home lives together 
live_together(X, Y, Z) :- 
    at_home(X), at_home(Y), at_home(Z).

% #8: Anyone who lives together are friends 
friends(X, Y, Z) :- 
    live_together(X, Y, Z).

% #9: Anyone who is dead is the vicitm
victim(X):-
    is_dead(X).

/*
Queries 
?- victim(X). --> john
?- findall(X, in_room(X), Bag). --> Bag=[john]
?- access_to_weapon(X); hero_suspects(X) --> [evan]
?- has_alibi(X), access_to_weapon(X). --> [emilie]
?- findall(X, at_home(X), Bag). --> [emilie, john]
?- findall(X, murder(X), Bag). --> Bag=[evan]
*/


