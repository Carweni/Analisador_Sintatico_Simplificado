<a name="readme-top"></a>

# Analisador_Sintatico_Simplificado
Projeto que realiza a etapa de análise sintática do processo de compilação para uma linguagem em notação BNF apresentada abaixo.

## Pré-Requisitos:
Para conseguir rodar o projeto em sua máquina, além de um compilador para a linguagem C, será necessária a instalação das ferramentas Flex(gerador de analisadores léxicos) e Bison(gerador de analisadores sintáticos).

### Para o Linux:
- Instalação via APT:
```bash
sudo apt-get update
sudo apt-get install flex
sudo apt-get install bison
```

### Para o Windows:
- [Baixar Flex](https://gnuwin32.sourceforge.net/packages/flex.htm)
- [Baixar Bison](https://gnuwin32.sourceforge.net/packages/bison.htm)

## Como iniciar o projeto:

1. Clone o repositório e abra a sua pasta:

```bash
git clone https://github.com/Carweni/Analisador_Sintatico_Simplificado.git
cd Analisador_Sintatico_Simplificado
```

2. Execute os seguintes comandos para compilar o projeto:

```bash
flex scanner.l
bison bison -dy parser.y
gcc -oexecutable lex.yy.c y.tab.c
```
3. Execute o programa com um arquivo de teste(como o adicionado no projeto), ou com algum outro texto.

```bash
.\executable.exe test.txt
```

A saída será uma frase dizendo se o código está ou não sintaticamente correto.

## Linguagem analisada:
<img src=".\schemas\language.jpg" alt="paranadex diagram" width="auto"  height="auto" />

<p align="right">(<a href="#readme-top">Voltar ao topo</a>)</p>