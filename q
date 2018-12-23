
[1mFrom:[0m /home/jeremy/code/02_CLI/what_dis_ruby/lib/command_line_interface.rb @ line 49 CommandLineInteface#identify_and_render_class_and_method:

    [1;34m48[0m:   [32mdef[0m [1;34midentify_and_render_class_and_method[0m(first_choice)
 => [1;34m49[0m: binding.pry 
    [1;34m50[0m:     [32mif[0m validate_choice_input(first_choice) == { [31m[1;31m"[0m[31mvalid class[1;31m"[0m[31m[0m => [1;36mtrue[0m, [31m[1;31m"[0m[31mvalid method[1;31m"[0m[31m[0m => [1;36mtrue[0m, [31m[1;31m"[0m[31minputs[1;31m"[0m[31m[0m => [1;34m2[0m}
    [1;34m51[0m:       class_choice = first_choice.split([31m[1;31m'[0m[31m,[1;31m'[0m[31m[0m)[[1;34m0[0m].strip
    [1;34m52[0m:       @current_class = set_class(class_choice)
    [1;34m53[0m:       method_choice = first_choice.split([31m[1;31m'[0m[31m,[1;31m'[0m[31m[0m)[[1;34m1[0m].strip
    [1;34m54[0m:     [32melsif[0m validate_choice_input(first_choice) == { [31m[1;31m"[0m[31mvalid class[1;31m"[0m[31m[0m => [1;36mtrue[0m, [31m[1;31m"[0m[31mvalid method[1;31m"[0m[31m[0m => [1;36mfalse[0m, [31m[1;31m"[0m[31minputs[1;31m"[0m[31m[0m => [1;34m1[0m}
    [1;34m55[0m:       @current_class = set_class(first_choice)
    [1;34m56[0m:       printf_method_list(@current_class)
    [1;34m57[0m:       puts [31m[1;31m'[0m[31mPlease enter the method you wish to view:[1;31m'[0m[31m[0m
    [1;34m58[0m:       method_choice = gets.strip
    [1;34m59[0m:     [32melsif[0m validate_choice_input(first_choice) == { [31m[1;31m"[0m[31mvalid class[1;31m"[0m[31m[0m => [1;36mtrue[0m, [31m[1;31m"[0m[31mvalid method[1;31m"[0m[31m[0m => [1;36mfalse[0m, [31m[1;31m"[0m[31minputs[1;31m"[0m[31m[0m => [1;34m2[0m}
    [1;34m60[0m:       @current_class = set_class(first_choice.split([31m[1;31m'[0m[31m,[1;31m'[0m[31m[0m)[[1;34m0[0m].strip)
    [1;34m61[0m:       printf_method_list(@current_class)
    [1;34m62[0m:       puts [31m[1;31m'[0m[31mPlease enter the method you wish to view:[1;31m'[0m[31m[0m
    [1;34m63[0m:       method_choice = gets.strip
    [1;34m64[0m:     [32melse[0m
    [1;34m65[0m:       puts [31m[1;31m"[0m[31mHmmmm... I couldn't make sense of your input.  Let's try this[1;31m"[0m[31m[0m [32mif[0m first_choice != [31m[1;31m'[0m[31m[1;31m'[0m[31m[0m
    [1;34m66[0m:       printf_class_list
    [1;34m67[0m:       puts [31m[1;31m'[0m[31mPlease enter the name of the class for which you wish to view available methods:[1;31m'[0m[31m[0m
    [1;34m68[0m:       class_choice= gets.strip
    [1;34m69[0m:       @current_class = set_class(class_choice)
    [1;34m70[0m:       printf_method_list(@current_class)
    [1;34m71[0m:       puts [31m[1;31m'[0m[31mPlease enter the method you wish to view:[1;31m'[0m[31m[0m
    [1;34m72[0m:       method_choice = gets.strip
    [1;34m73[0m:     [32mend[0m
    [1;34m74[0m:         display_method(@current_class, method_choice)
    [1;34m75[0m: 
    [1;34m76[0m:   [32mend[0m

