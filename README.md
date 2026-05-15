[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/kRZICgXV)
## PROJETO JACA: A construção de um compilador para uma linguagem em cinco passos ##

Nesse projeto, nós vamos desenvolver todas as etapas necessárias para conseguirmos escrever uma nova linguagem: a linguagem **JACA** proposta pelo **Prof. Marco Antonio Furlan de Souza**

Durante o desenvolvimento do projeto, vamos encontrar alguns desafios e a solução deles exigirá o uso da teoria apresentada em sala, nas apostilas e nas documentações.

Ao final, teremos uma nova linguagem pronta para uso!

Nosso projeto está organizado da seguinte forma:

```
/cic303-2026-1
 ├── README.md                      <-- Este arquivo com a organização geral do projeto
 ├── /docs                          <-- PDFs com a teoria, slides e especificação da JACA.
 │
 ├── /fase01-o-caos-das-strings     <-- Projeto Maven (Apenas JUnit e código Java puro)
 ├── /fase02-automatizando-lexico   <-- Projeto Maven (Adiciona o plugin do JFlex)
 ├── /fase03-o-problema-da-ordem    <-- Projeto Maven (Adiciona o plugin do CUP)
 ├── /fase04-dando-significado      <-- Projeto Maven (JFlex + CUP + Classes da AST)
 └── /fase05-o-grande-final         <-- Projeto Maven (Escrevendo e executando operações em JACA)
```

 Cada uma das fases terá um validador que será utilizado para definir se o você obteve sucesso na execução da atividade ou não. 
 
 Para executar o validador, você deverá executar o seguinte comando:

```bash
 mvn test -f .\fase01-o-caos-das-strings\pom.xml
```

 Se a sua solução estiver correta, após efetuar o commit e o push para o seu fork do repositório, você irá ver um símbolo indicando o sucesso, como esse:
 

<img width="1846" height="484" alt="image" src="https://github.com/user-attachments/assets/8e164751-8610-4f6d-9f2d-667b2e2d9cf7" />

Se a sua solução ainda apresentar algum problema, o resultado será indicado dessa forma:

<img width="1825" height="560" alt="image" src="https://github.com/user-attachments/assets/69936206-3641-4727-b9cb-3461f9cc2243" />




