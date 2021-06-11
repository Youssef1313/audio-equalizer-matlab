%% get_string helper function
% takes a message to display to the user, and keep asking the user to enter
% a valid string based on the validitation predicate.
function f = get_string(prompt, predicate)
    while 1
        s = input(prompt, 's');
        if predicate(s)
            f = s;
            break;
        end
    end
end