-module(records).
-compile(export_all).
-include("records.hrl").

-record(robot, {name,
                type = industrial,
                hobbies,
                details = []}).

included() -> #included{some_field="Some value"}.

first_robot() ->
    #robot{name = "Mechatron",
           type = handmade,
           details = ["Moved by a small man inside"]}.

gurren_lagann() -> #robot{name = "Gurren Lagann",
                        type = battle,
                        hobbies = "Drill",
                        details = ["With your Drill, Pierce the Heavens!!"]}.

repairman(Rob) ->
    Details = Rob#robot.details,
    NewRob = Rob#robot{details=["Repaired by Jorj Freeman"|Details]},
    {repaired, NewRob}.




-record(user, {id, name, group, age}).

admin_panel(#user{name=Name, group=admin}) ->
    Name ++ " is allowed!";
admin_panel(#user{name=Name}) ->
    Name ++ " is not allowed".

adult_section(U = #user{}) when U#user.age >= 18 ->
    allowed;
adult_section(_) ->
    forbidden.