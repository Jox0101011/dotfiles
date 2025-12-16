 function detect_os
         switch (uname)
             case Linux
                 echo -e "\e[1;4;33mHi Tux!\e[0m"
             case Darwin
                 echo -e "\e[1;4;34mHi Hexley!\e[0m"
             case '*BSD' DragonFly
                 echo -e "\e[1;4;32mHi Beastie!\e[0m"
             case '*'
                 echo "\e[1;4;31mHi stranger!\e[0m"
         end
     end

