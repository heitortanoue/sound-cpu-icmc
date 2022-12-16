# SOUND - Processador ICMC

> Adicionado comando *SOUND*, que corresponde ao número 52 (110001) no processador.

```assembly
SOUND RX, RX, RZ
( 110001 / RX / RY / RZ / x )
```
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Waveforms.svg/600px-Waveforms.svg.png" alt="wave_forms" width="230" align="right"/>

-   **RX**: frequência da onda em *dHz* (*10 dHz = 1 Hz*)
-   **RY**: duração em _ms_
-   **RZ**: tipo de onda
    -   0: sineWave
    -   1: squareWave
    -   2: triangleWave
    -   3: sawtoothWave



## Como rodar
###  Usando os arquivos do repositório
1. Clone esse repositório para seu computador
```bash
git clone https://github.com/totoi690/sound-cpu-icmc
```
2. Entre na pasta ```files``` e rode o ```montador``` e depois o ```simulador```
```bash
cd ./files
./montador nome_arquivo.asm
./simulador nome_arquivo.mif charmap.mif
```

### Compilando a partir do código-fonte
1. Clone esse repositório para seu computador
```bash
git clone https://github.com/totoi690/sound-cpu-icmc
```
2. Entre na pasta ```montador``` e gere o arquivo final através do comando
```bash
cd ./montador
make all
```
2. Entre na pasta ```simulador``` e gere o arquivo final através do comando
```bash
cd ./simulador
sh compila.sh
```

- ***OBS***: Dentro da pasta ```files``` existe um jogo de teste que deve fazer um som assim que a tecla ENTER for pressionada.

## Requisitos para compilação
- Compiladores GCC e G++
- Bibliotecas
	- GTK2
	- SDL2

## Implementações
### Montador
- Inserção do código "110001" (*SOUND*) no ```montador.c```.

### Simulador
- Adição da biblioteca SDL2 para implementação do som
	- Adionada a flag ```-lSDL2``` no ```compila.sh``` para inclusão da biblioteca
	- Gerador de funções sonoras no arquivo ```Sound.cpp```
	- Programação das funções sonoras seno, quadrada, triangular e dente-de-serra
- Modificação da classe ```Model``` e de seu método ```processador``` para aceitarem o novo código *SOUND*.

## Participantes
- [Heitor Tanoue](https://github.com/totoi690)
- [Beatriz Cardoso](https://github.com/trizcard)
