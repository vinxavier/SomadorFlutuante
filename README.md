# SomadorFlutuante

Projeto de um somador de ponto flutuante para a disciplina de sistemas digitais usando uma placa FPGA.

O projeto foi realizado usando a placa Cyclone II da Altera.

Ele foi inspirado no projeto FP_Adder do livro do Pong Chu. Inclusive foi utilizado alguns módulos desse projeto.

O projeto tem dois números ponto flutuante como entrada, compostos por um sinal, expoente e parte fracionária. Então é realizada a soma entre esses dois números e mostrado o resultado na placa.

# Configuração do projeto na placa

Dividimos a placa em um processo de estado, onde a chave vai dizer o estado. Os estados vão de 0, a 6.

- Estado 0: Utiliza SW4 para dizer o sinal do número 1, Utitliza SW0-SW3 para definir o expoente do número 1, e ao apertar KEY0 confirma o sinal e o expoente e vai para o próximo estado. É possível ver na tela sinal e expoente desse número.
    
- Estado 1: Utiliza SW0-SW7 para definir a parte fracionária do número 1, e aperta KEY0 para confirmar e ir para o próximo estado.
    
- Estado 2: Mostra a Entrada 1 na tela, e KEY0 para confirmar e ir para o próximo estado.
    
- Estado 3: Utiliza SW4 para dizer o sinal do número 2, Utitliza SW0-SW3 para definir o expoente do número 2, e ao apertar KEY0 confirma o sinal e o expoente e vai para o próximo estado. É possível ver na tela sinal e expoente desse número.

- Estado 4: Utiliza SW0-SW7 para definir a parte fracionária do número 2, e aperta KEY0 para confirmar e ir para o próximo estado. É possível ver na tela sinal e expoente desse número.

- Estado 5: Mostra a Entrada 2 na tela, e KEY0 para confirmar e ir para o próximo estado.

- Estado 6: É o estado resposta. Neste estado o resultado será exibido no 7 Segment display e nos LEDs. Ao apertar KEY0, volta ao estado 0.

    Ao apertar KEY1 cancela a operação e volta ao estado 0.


Foi desenvolvido e realizado por Vinícius Soares Xavier e Jairo da Silva Freitas Junior, na disciplina de Sistemas Digitais, com o professor José Artur Quilici.
