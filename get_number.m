%% get_number helper function
% takes a message to display to the user, and keep asking the user to enter
% a valid real number based on the validitation predicate.
function f = get_number(prompt, predicate)
    while 1
        x = inputdlg(prompt);
        n = str2double(x{1});
        if length(n) == 1 && isreal(n) && predicate(n)
            f = n;
            break;
        end
    end
end
