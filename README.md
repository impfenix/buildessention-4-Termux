# **BuildEssention-4-Termux**


**Script \"Build Essential\" para Termux**


Este repositório contém um script de shell projetado para configurar um ambiente de desenvolvimento robusto e completo dentro do Termux no Android. O objetivo é instalar todas as ferramentas e bibliotecas essenciais necessárias para compilar software a partir do código-fonte, com foco especial em aplicações C/C++ que utilizam o toolkit gráfico GTK3.


Para validar a configuração do ambiente, o script baixa, compila e instala automaticamente o utilitário yad (Yet Another Dialog), um teste prático que utiliza muitas das dependências instaladas.


**Sobre o Projeto**


A compilação de software no Termux pode ser desafiadora devido às suas diferenças em relação a uma distribuição Linux de desktop padrão. Questões como a ausência de pacotes -dev, a necessidade de bibliotecas de compatibilidade específicas do Android (como libandroid-shmem) e dependências com nomes de pacotes diferentes podem tornar o processo frustrante.


Este script é o resultado de um processo detalhado de depuração, resolvendo cada erro de dependência passo a passo, para criar um fluxo de instalação automatizado e confiável.


**Funcionalidades**


*   **Atualização do Sistema:** Garante que o pkg (gerenciador de pacotes do Termux) esteja com as listas de repositórios atualizadas.


*   **Instalação de Ferramentas Essenciais:** Instala um conjunto completo de ferramentas de compilação, incluindo build-essential (que fornece clang), autoconf, automake, libtool, pkg-config, git e wget.


*   **Ambiente Python:** Configura um ambiente de desenvolvimento Python com pip, ninja e meson.


*   **Dependências Gráficas e GTK3:** Instala a suíte completa de bibliotecas necessárias para compilação de aplicações GTK3, como gtk3, pango, libcairo, gdk-pixbuf, libxml2, libjpeg-turbo, entre outras, todas com os nomes de pacotes corretos para o Termux.


*   **Dependências Específicas:** Instala pacotes que foram identificados como necessários durante a compilação, como intltool, xorgproto e o módulo Perl XML::Parser.


*   **Correção de Compatibilidade:** Aplica a correção necessária para a compilação no Termux, exportando a flag LDFLAGS=\"-landroid-shmem\" para lidar com as funções de memória compartilhada.


*   **Teste de Validação:** Baixa, compila e instala o yad v14.1 para confirmar que o ambiente de desenvolvimento está funcionando corretamente.


### **Requisitos**


#### 1.  **[Termux:](https://github.com/termux/termux-app)** O aplicativo Termux instalado no seu dispositivo Android. É altamente recomendável usar a versão do [Github oficial](https://github.com/termux/termux-app).


#### 2.  **[Termux:X11](https://github.com/termux/termux-x11):** Para testar a aplicação gráfica (yad) compilada, você precisará do aplicativo Termux:X11.


#### 3.  **Conexão com a Internet:** Para baixar os pacotes e o código-fonte.


### **Como Usar**


* **1- Abra o Termux e instale o git:**

    ```
    pkg install git -y
    ```


* **2- Clone este repositório:**

    ```
    git clone https://github.com/impfenix/buildessention-4-Termux.git
    ```


* **3- Navegue até o diretório do script:**

    ```
    cd buildessention-4-Termux/Bash
    ```


* **4- Dê permissão de execução ao script:**

    ```
    chmod +x build_essential_termux.sh
    ```


* **5- Execute o script:**


    ```
    ./build_essential_termux.sh
    ```
    

    O script cuidará de todo o processo. Ele pode levar vários minutos, dependendo da velocidade do seu dispositivo e da sua conexão com a internet.


**Verificação Pós-Instalação**


Após a conclusão bem-sucedida do script, você pode verificar se o ambiente está funcional testando o yad.


1.  Abra o aplicativo **Termux:X11**.


2.  Volte para o Termux e execute o seguinte comando:

    ```
    termux-x11 :0 -xstartup "yad --title='Sucesso!' --text='Ambiente de desenvolvimento configurado!' --button=OK"
    ```

    Uma janela de diálogo gráfica deve aparecer na tela do Termux:X11, confirmando que a compilação e a instalação foram bem-sucedidas.


**Licença**


Este projeto está licenciado sob a **Licença Pública Geral GNU v3.0.**



