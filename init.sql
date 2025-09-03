DROP TABLE IF EXISTS test_questions CASCADE;
DROP TABLE IF EXISTS tests CASCADE;
DROP TABLE IF EXISTS answer_option CASCADE;
DROP TABLE IF EXISTS question CASCADE;
DROP TABLE IF EXISTS topic CASCADE;
DROP TABLE IF EXISTS subject CASCADE;

CREATE TABLE subject (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE topic (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    subject_id INT REFERENCES subject(id) ON DELETE CASCADE
);

CREATE TABLE question (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    subject_id INT REFERENCES subject(id) ON DELETE CASCADE,
    topic_id INT REFERENCES topic(id) ON DELETE CASCADE
);

CREATE TABLE answer_option (
    id SERIAL PRIMARY KEY,
    question_id INT REFERENCES question(id) ON DELETE CASCADE,
    text TEXT NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE tests (
    id SERIAL PRIMARY KEY,
    num_questions INTEGER NOT NULL,
    subject_id INTEGER REFERENCES subject(id),
    topic_id INTEGER REFERENCES topic(id),
    completed BOOLEAN DEFAULT FALSE,
    score FLOAT
);

CREATE TABLE test_questions (
    id SERIAL PRIMARY KEY,
    test_id INTEGER NOT NULL REFERENCES tests(id) ON DELETE CASCADE,
    question_id INTEGER NOT NULL REFERENCES question(id),
    user_selected_option_id INTEGER REFERENCES answer_option(id),
    is_correct BOOLEAN,
    UNIQUE(test_id, question_id)
);

CREATE INDEX idx_question_subject_id ON question(subject_id);
CREATE INDEX idx_question_topic_id ON question(topic_id);
CREATE INDEX idx_answer_option_question_id ON answer_option(question_id);
CREATE INDEX idx_tests_subject_id ON tests(subject_id);
CREATE INDEX idx_tests_topic_id ON tests(topic_id);
CREATE INDEX idx_test_questions_test_id ON test_questions(test_id);
CREATE INDEX idx_test_questions_question_id ON test_questions(question_id);

INSERT INTO subject (name) VALUES 
('Engenharia de Software'),
('Sistemas Operacionais');


INSERT INTO topic (name, subject_id) VALUES
('Capitulo 1',1),
('Capitulo 2',1),
('Capitulo 3',1),
('Capitulo 4',1),
('Capitulo 1',2),
('Capitulo 2',2),
('Capitulo 3',2),
('Capitulo 4',2);

INSERT INTO question (text, subject_id, topic_id) VALUES
('Por vários anos não existiam muitos critérios para desenvolver programas de computador; tudo era feito de acordo com a necessidade e a capacidade técnica do programador. Esse processo de desenvolvimento associado ao rápido progresso do hardware e a falta de técnicas eficientes no desenvolvimento de software, levou a problemas relacionados às demandas de software cada vez mais complexas, fazendo com que os desenvolvedores, muitas vezes, se perdessem nas soluções e na organização dos trabalhos. Para buscar uma solução para esse problema, no ano de 1968 cientistas da computação se reuniram sob o patrocínio de qual organização? Marque a opção correta.',1,1),
('Baseado no modelo em cascata, o _______ tem diversas pequenas cascatas no projeto, cada uma delas representando uma entrega ao cliente com uma melhoria. A ideia desse modelo é, há medida que o software tenha a primeira funcionalidade usável, ele é submetido ao cliente para que este use, avalie, teste e opine sobre aquela funcionalidade. Assim o processo se repete em cada liberação até que o produto final esteja completo.
Avalie as afirmações a seguir e marque a que preenche o espaço vazio no texto acima.',1,1),
('As afirmações abaixo se propõem elencar as quatro atividades básicas do processo; analise cuidadosamente cada uma delas:
I – Especificação.
II – Qualidade.
III – Validação.
IV – Elicitação.
É correto o que se afirma em:',1,1),
('Considerando as etapas do modelo em cascata, leia atentamente as afirmações a seguir e faça o que se pede.
I – Operação e manutenção.
II – Análise e definição de requisitos.
III – Implementação e teste unitário.
IV – Integração e teste de sistema.
V – Projeto de sistema e software.
É correto o que se afirma em:',1,1),
('Analise a frase a seguir:
“Grande parte da crise de software é autoimposta, segundo um CIO, ‘Prefiro ter o software errado e não atrasado. Sempre podemos corrigir depois”.
Marque a alternativa que melhor representa a realidade da produção e a qualidade de software no século XXI.',1,1),
('Não é possível existir ordem se não houver gerência e no gerenciamento de projeto de software são muitas as tarefas a serem administradas e mantidas em ordem. O guia PMBOK traz uma definição para a expressão “gerenciamento de projetos” cuja compreensão poder ser que, por meio do gerenciamento, é possível executar projetos de maneira eficaz e eficiente. Tendo em mente a expressão gerenciamento de projetos, analise as afirmações a seguir e marque a que apresenta a definição correta sobre o tema.',1,1),
('Avalie os modelos a seguir e marque a alternativa que apresenta corretamente os modelos evolucionários.
I - Modelo cascata.
II - Modelos de processo incremental.
III - Prototipação.
IV - Modelo Espiral.
São modelos evolucionários:',1,1),
('Sendo uma disciplina da engenharia, a engenharia de software deve ter princípios muito bem estabelecidos. Esta área trata de todos os aspectos da produção de software apoiando o desenvolvimento profissional com qualidade, em tempo hábil e custo adequado. Também envolve técnicas de especificação, projeto e evolução de software, abordagens sistemáticas e disciplinadas com o objetivo de desenvolver, operar, manter e evoluir o software. Tendo em vista esta afirmação, analise as opções a seguir e marque a que apresenta a definição correta para Engenharia de Software.',1,1),
('O desenvolvimento de software sofre forte influência do mundo real; como consequência disso o desenvolvimento acaba se voltando à prática do que a um conjunto de conhecimentos específicos. Isso nos leva a entender que as atividades de desenvolvimento da engenharia de software são mais artesanais do que necessariamente uma prática formalizada.
Para formalizar a prática de desenvolvimento de software, e tornar essa atividade organizada e ordenada, foram desenvolvidos os modelos de processo de software, ou, paradigmas da engenharia de software. Analise as afirmações a seguir e marque aquela que apresenta corretamente 3 modelos de processo de software.',1,1),
('Quatro anos depois das discussões sobre a crise do software, Edsger Dijkstra escreve um artigo fazendo uma avaliação dos problemas enfrentados na engenharia de software, ele destacava os já discutidos problemas e ainda elencava outros pontos cruciais no desenvolvimento de software. Analise os itens que se propõem a ser os pontos cruciais destacados por Dijkstra:
I – Projetos que excedem o cronograma definido.
II – Projetos que ultrapassam o orçamento.
III – Produto final com baixa qualidade.
IV – Produto final que não atenda aos requisitos.
V – Produtos finais que não apresentam capacidades gerenciáveis.
VI – dificuldade de manutenção e evolução dos softwares.
Marque a alternativa que apresenta corretamente os pontos cruciais destacados por Dijkistra.',1,1),

('Analise a frase a seguir:
“Grande parte da crise de software é autoimposta, segundo um CIO, ‘Prefiro ter o software errado e não atrasado. Sempre podemos corrigir depois”.
Marque a alternativa que melhor representa a realidade da produção e a qualidade de software no século XXI.',1,2),
('Software pode ser definido como sendo um programa de computador e a sua documentação associada e o seu produto pode ser desenvolvido tanto para um único cliente ou para o mercado de maneira geral. Após analisar as afirmações a seguir, marque a alternativa correta.
Software consiste em:
I – Instruções (programas de computador) que, quando executadas, fornecem características, funções e desempenho desejados.
II – Estruturas de dados que possibilitam aos programas manipular informações adequadamente.
III – Informação descritiva, tanto na forma impressa como na virtual, descrevendo a operação e o uso dos programas.
É correto o que se afirma:',1,2),
('O contexto do software é mais abrangente do que somente um programa sendo executado sobre um computador para apresentar algum resultado ao usuário. Atualmente temos o que é chamado de software embarcado que atua como controlador de muitos dispositivos eletrônicos. Considerando o tema software embarcado, analise as afirmações a seguir e marque a que apresenta a definição correta sobre o assunto.',1,2),
('Todo projeto deve ter um começo, meio e fim e para que seja possível visualizar cada uma das etapas é importante que se definam o cronograma do projeto. A forma de definir um cronograma de um projeto de software não é muito diferente da maneira que se desenvolve um cronograma para qualquer outro projeto. Assim é possível empregar ferramentas e técnicas comuns a outros tipos de projetos, com alguns poucos ajustes podem ser empregados nos projetos de software. Diante da afirmação acima e considerando o diagrama de PERT, analise as afirmações a seguir e marque a opção correta.
I – A Rede de PERT é um grafo de dependência entre as atividades do projeto.
II - Seu uso, normalmente, é para projetos de grande escala.
III - Permite identificar o tempo que cada tarefa levará para ser concluída estimando os requisitos de tempo mais curtos, longos e prováveis.
É correto o que se afirma em:',1,2),
('Os primeiro programas de computador eram feitos por meio de cartões perfurados. e essa programação perdurou por muito tempo. Esses cartões eram o principal meio para se comunicar com o computador, além de serem um mecanismo eficiente para o armazenamento de dados, já que toda a instrução dada ao computador era feita pelos cartões que poderiam ser guardados e reutilizados quando necessário.
Com base no texto acima, analise as afirmações a seguir e marque a opção correta.',1,2),
('O mundo como conhecemos hoje não poderia existir sem o software. Praticamente tudo se resume a programas de computadores, estamos cercados por eles e os usamos em quase todas as nossas tarefas. Logo após o surgimento da chamada microprogramação também surgem as primeiras linguagens de programação. Com a microprogramação os computadores e os softwares começaram a evoluir para o que conhecemos hoje. Entretanto, cerca de 100 anos antes, Ada Lovelace já havia desenvolvido o conceito de programação para a máquina analítica de Charles Babbage.
Tendo em vista o texto apresentado acima, avalie as afirmações a seguir e a relação proposta entre elas.
I – O projeto de Ada Lovelace e Charles Babbage nunca sai do papel.
PORQUE:
II – Os recursos financeiros de ambos não eram suficientes para custear um projeto tão caro e complexo como o apresentado por Babbage.
A respeito dessas afirmações, assinale a opção correta.',1,2),
('Sendo uma disciplina da engenharia, a engenharia de software deve ter princípios muito bem estabelecidos. Esta área trata de todos os aspectos da produção de software apoiando o desenvolvimento profissional com qualidade, em tempo hábil e custo adequado. Também envolve técnicas de especificação, projeto e evolução de software, abordagens sistemáticas e disciplinadas com o objetivo de desenvolver, operar, manter e evoluir o software. Tendo em vista esta afirmação, analise as opções a seguir e marque a que apresenta a definição correta para Engenharia de Software.',1,2),
('Quatro anos depois das discussões sobre a crise do software, Edsger Dijkstra escreve um artigo fazendo uma avaliação dos problemas enfrentados na engenharia de software, ele destacava os já discutidos problemas e ainda elencava outros pontos cruciais no desenvolvimento de software. Analise os itens que se propõem a ser os pontos cruciais destacados por Dijkstra:
I – Projetos que excedem o cronograma definido.
II – Projetos que ultrapassam o orçamento.
III – Produto final com baixa qualidade.
IV – Produto final que não atenda aos requisitos.
V – Produtos finais que não apresentam capacidades gerenciáveis.
VI – dificuldade de manutenção e evolução dos softwares.
Marque a alternativa que apresenta corretamente os pontos cruciais destacados por Dijkistra.',1,2),
('O desenvolvimento de software sofre forte influência do mundo real; como consequência disso o desenvolvimento acaba se voltando à prática do que a um conjunto de conhecimentos específicos. Isso nos leva a entender que as atividades de desenvolvimento da engenharia de software são mais artesanais do que necessariamente uma prática formalizada.
Para formalizar a prática de desenvolvimento de software, e tornar essa atividade organizada e ordenada, foram desenvolvidos os modelos de processo de software, ou, paradigmas da engenharia de software. Analise as afirmações a seguir e marque aquela que apresenta corretamente 3 modelos de processo de software.',1,2),
('Baseado no modelo em cascata, o _______ tem diversas pequenas cascatas no projeto, cada uma delas representando uma entrega ao cliente com uma melhoria. A ideia desse modelo é, há medida que o software tenha a primeira funcionalidade usável, ele é submetido ao cliente para que este use, avalie, teste e opine sobre aquela funcionalidade. Assim o processo se repete em cada liberação até que o produto final esteja completo.
Avalie as afirmações a seguir e marque a que preenche o espaço vazio no texto acima.',1,2),

('A manutenção do software faz parte do ciclo de vida do sistema e seu objetivo é fazer modificações no sistema existente mantendo sua integridade, estrutura e funcionalidades originais, inclusive algumas atividades de manutenção são importantes mesmo antes da entrega final do projeto.

Alguns problemas que levam um sistema a passar por manutenção são:

I – Tendências de mercado.

II – Adequação a novas tecnologias de hardware e sistema operacional.

III – Com o passar do tempo o código original fica cheio de novas linhas.

IV -  O código fica difícil de entender.

É correto o que se afirma em:',1,3),
('Para minimizar ao máximo os problemas que podem surgir no ambiente de trabalho do cliente, existe um conjunto de testes que devem ser realizados durante o processo de codificação do sistema e depois de finalizada a etapa de codificação. Sabendo da necessidade e importância dos testes, marque a alternativa que apresenta corretamente a função dos testes.',1,3),
('Avalie as afirmações a seguir que se propõem tratar sobre boas práticas para declarar requisitos de software:

I – Ao declarar um requisito ela deve ser feita de maneira clara.

II – A declaração de um requisito deve ser feita sem ambiguidade.

III – O requisito deve ser declarado de maneira qualitativa.

IV – O requisito deve ser, sempre que apropriado, declarado de maneira quantitativa.

 É correto o que se afirma em:',1,3),
('Leia atentamente a afirmação a seguir.

“Nessa fase do projeto é necessário compreender o problema a ser resolvido com um programa computacional descobrindo, analisando, documentando e verificando cada necessidade e restrições do problema atual.”

Esta afirmação trata de que atividade em um projeto de software? Marque a alternativa correta.',1,3),
('A elicitação de requisitos é considerada uma das fases mais importantes do projeto de software; é sabido que falhas nessa fase podem afetar o desempenho do sistema acarretando inclusive em prejuízo financeiro.

Analise as duas sentenças a seguir que se propõem tratar sobre o tema:

I – É na fase do levantamento e especificação dos requisitos que podem surgir problemas no sistema que só refletirão mais tarde, normalmente quando o software já estiver em uso pelo cliente.

II – A eficácia de um software vai depender do nível dos requisitos elicitados, se eles realmente refletem a necessidade para a qual o programa vai ser desenvolvido.

É correto o que se afirma em:',1,3),
('A eficiência do projeto está relacionada à qualidade da interação entre o cliente, o projeto a equipe de desenvolvimento e os demais envolvidos no projeto. Esse é o mundo ideal para que os problemas durante a execução do projeto sejam minimizados e muitas vezes rapidamente solucionados. Considerando esse quadro, analise as afirmações a seguir:

I – Os métodos ágeis incentivam e estabelecem como regra a plena integração do cliente com o projeto de software e os demais membros da equipe, contudo isso nem sempre é viável.

Porque

II – Questões como localização geográfica, pouco contato entre o cliente e a equipe, pouco conhecimento técnico por parte do cliente e opiniões conflitantes são algumas das barreiras que impedem essa integração.

É correto o que se afirma em:',1,3),
('Para conseguir que os testes tenham a mais alta probabilidade de descobrir erros no software, quais são as categorias diferentes de técnicas de projeto de caso de teste usadas? Marque a alternativa correta.',1,3),
('É comum que os requisitos sejam classificados entre requisitos funcionais e não funcionais. Sobre os requisitos funcionais, avalie as afirmações a seguir e marque a que apresenta a definição correta sobre o assunto.',1,3),
('Para minimizar o problema de erros na classificação dos tipos de requisitos, existem duas classes, avalie as alternativas a seguir e marque a que apresenta as classes corretamente.',1,3),
('Os requisitos de um sistema são ______.

Avalie cuidadosamente as alternativas a seguir e marque a que preenche corretamente o espaço vazio da frase acima.',1,3),

('São boas práticas de programação de software, avalie as afirmações a seguir marque a alternativa correta.

I. Identar o código.

II. Nomear variáveis, funções e métodos de forma intuitiva.

III. Desenvolver o código pensando no reúso.

IV. Atentar para a segurança do sistema em desenvolvimento.

 

É correto o que se afirma em:',1,4),
('O conceito herança é muito importante para a compreensão e o emprego do conceito de polimorfismo, pois é possível programar de maneira que os objetos que compartilham uma classe pai sejam programados como se fossem os objetos da própria classe pai simplificando o processo de programação e tornando os sistemas facilmente extensíveis com a adição de novas classes com quase nenhuma modificação.

Considerando o texto acima, analise a sentença a seguir e preencha os espaços vazios.
 

Em resumo, ___ rege duas ou mais ___ derivadas de maneira que, a partir de uma ___, as derivadas podem ___ métodos que tenham a mesmas ___ , porém com comportamentos ___ para cada subclasse.',1,4),
('Considerando a abstração, um dos quatro pilares da programação orientada a objetos, avalie as alternativas a seguir e marque a que apresenta a definição correta para o tema.',1,4),
('Com o surgimento da UML e sua posterior padronização pela OMG (Object Management Group), houve uma uniformidade na maneira de projetar sistemas computacionais e suas notações, diagramas e representações. A criação de diagramas para representar as etapas de desenvolvimento de software continua sendo a melhor forma de visualizar o projeto, contudo a partir da UML as representações do mundo real e suas abstrações se tornaram um pouco mais fáceis.

Avalie a lista a seguir e marque aquela que apresenta corretamente alguns dos diagramas da UML.

I.       Diagrama de fluxo de dados, Diagrama de Chapin, fluxograma, diagrama funcional.

II.      Diagrama de Gantt, diagrama de Venn, Diagrama de Pertt.

III.     Diagrama de dispersão, diagrama de linha, estereogramas, pictograma.

IV.    Diagrama de Estruturas compostas, diagrama de máquina de estados, diagrama de visão geral de integração.

É correto o que se afirma em:',1,4),
('A métrica de software é qualquer tipo de medição que pode ser estabelecida sobre a característica dos sistemas, documentação ou o processo de desenvolvimento que podem ser medidos de maneira objetiva dando condições ao gestor o acompanhamento do projeto. Ela pode ser dividida em dois tipos de métricas. Assinale a alternativa que apresenta corretamente essa divisão.',1,4),
('Sobre as métricas de previsão, ou métricas de projeto, qual das alternativas a seguir apresenta o uso correto para seus resultados? Assinale a alternativa correta.

',1,4),
('Assinale a alternativa que apresenta a finalidade correta para a métrica de controle.

',1,4),
('Ao empregar herança na codificação de um sistema podemos criar novas classes a partir de outras já existentes aproveitando os comportamentos da classe pai, absorvendo seus atributos e acrescentando outros recursos que se façam necessários para a nova classe; com esse processo é perfeitamente possível economizar tempo durante o desenvolvimento

Por meio da herança é possível construir classes genéricas, e a partir delas desenvolver classes mais específicas. Considerando os conceitos de especialização e generalização, Analise as definições de cada uma e faça o que se pede.

I. Especialização – é vista de baixo para cima em uma relação entre as classes pai e filho.

II. Generalização – é vista de cima para baixo na relação entre as classes pai e filho.

É correto o que se afirma em:',1,4),
('O encapsulamento faz a restrição de acesso aos atributos, métodos ou à própria classe ocultando os detalhes da implementação ao usuário daquela classe. Ele separa e mantém ocultos os aspectos externos do objeto dos detalhes internos da implementação impedindo o acesso direto às propriedades de um objeto.

Para que ele possa fazer essa restrição ele se utiliza de 3 qualificadores. Avalie cada um deles e relacione com sua respectiva definição.
1 - Public

2 - Private

3 - Protected

A - O método ou o atributo são acessíveis apenas por métodos da própria classe.

B -   O método ou o atributo são acessíveis pela própria classe, por classes do mesmo pacote ou classes da mesma hierarquia.

C - Método ou o atributo são acessíveis por qualquer classe

',1,4),
('Sabendo que um paradigma é um modelo a ser seguido e que em engenharia de software paradigmas de programação são modelos definidos e, a partir deles, um desenvolvedor pode produzir softwares de maneira padronizada. Avalie as afirmações que se propõem ser paradigma de desenvolvimento de software, em seguida faça o que se pede.

São paradigmas de programação:

I.       Programação Orientada a Aspectos.

II.      Manifesto ágil.

III.     Programação não Estruturada.

IV.    Programação Funcional.

É correto o que se afirma em:',1,4),

('“Na primeira metade do século XX vários computadores mecânicos foram desenvolvidos e, com o passar do tempo, componentes eletrônicos foram adicionados aos projetos. Em 1931, Vannevar Bush implementou em um computador uma arquitetura binária propriamente dita usando os bits 0 e 1. A base decimal exigia que a eletricidade assumisse 10 voltagens, o que era muito difícil de ser controlado, por isso Bush usou a lógica de Boole, em que somente 2 níveis de voltagem eram suficientes.”

Fonte: https://www.tecmundo.com.br/tecnologia-da-informacao/1697-a-historia-dos-computadores-e-da-computacao.htm. Acesso em 05 jun. 2021

Sobre o histórico dos computadores, marque V (verdadeiro) e F (falso) e depois assinale a alternativa que contém a sequência correta.

( ) Os primeiros computadores surgiram com o objetivo de controlar equipamentos médico-hospitalares.

( ) O ENIAC foi o primeiro computador de uso pessoal desenvolvido e devido ao seu baixo custo permitiu que várias pessoas tivessem acesso à tecnologia digital.

( ) O desenvolvimento do transistor permitiu criar computadores mais baratos.',2,1),
('“Um processo pode ser entendido como um programa em execução. Para que a execução simultânea de diversos programas ocorra sem problemas é necessário que todas as informações do processo interrompido sejam salvas para que quando este voltar a ser executado não lhe falte nenhuma informação e possa continuar a execução exatamente no ponto onde estava quando foi interrompido.”

Fonte: https://sites.google.com/site/proffernandosiqueiraso/aulas/5-processo. Acesso em 25 mai. 2021

Sobre um processo cooperativo a única alternativa correta é:',2,1),
('Os primeiros sistemas operacionais não possuíam interface gráfica, o que obrigava os usuários a conhecerem e decorarem diversos comandos em formato de texto.

A partir dos estudos realizados, é correto afirmar que um sistema operacional é:',2,1),
('Um sistema operacional multiprogramável reduz o tempo de resposta e também o custo. Esse tipo de sistema operacional pode ser dividido em:

',2,1),
('O escalonamento de processos no sistema operacional permite manter o processador ocupado, equilibrando o uso da CPU entre os diversos processos.

Sobre os critérios de escalonamento, analise as afirmações a seguir:

I. Throughput: representa a quantidade de tempo utilizada para processar um programa.

II. Tempo de Espera: tempo total que o processo permanece na fila de pronto, esperando para ser executado.

III. Tempo de Turnaround: é o tempo que um processo leva desde sua criação até seu término.

É correto o que se afirma em:',2,1),
('Os threads compartilham o processador assim como os processos. Sobre os threads e processos, analise as afirmações a seguir:

I. Os processos são dependentes e os threads existem como um subprocesso.

II. Os processos possuem mais informações de estado do que os threads.

III. A alternância de contexto entre processos no mesmo hardware é tipicamente mais rápida que a alternância de contexto entre threads.

IV. Os threads procuram reduzir o tempo utilizado na criação, eliminação e troca de contexto de processos nas aplicações concorrentes e assim, economizam recursos do sistema como um todo.

É correto o que se afirma em:',2,1),
('Vivemos em um mundo no qual a tecnologia digital está presente no nosso dia a dia em todos os momentos, seja no trabalho, na vida pessoal, nos estudos, etc. Neste contexto, os sistemas computacionais estão presentes em nosso cotidiano.

Sobre os sistemas computacionais, marque a única alternativa correta:',2,1),
('Exceções e interrupções são eventos que podem ocorrer durante o processamento de um programa. Assinale a única alternativa correta em relação a exceções e interrupções:',2,1),
('“Concorrência é sobre a execução sequencial e disputada de um conjunto de tarefas independentes. Sob o ponto de vista de um sistema operacional, o responsável por esse gerenciamento é o escalonador de processos.”

Fonte: https://www.treinaweb.com.br/blog/concorrencia-paralelismo-processos-threads-programacao-sincrona-e-assincrona. Acesso em 05 mai. 2021.

Para implementação da concorrência em sistemas operacionais, quais são as formas possíveis?',2,1),
('“A memória RAM não tem qualquer tipo de influência sobre o desempenho do processador do computador, bem como não tem o poder de fazer com que o trabalho do processador fique mais rápido.”

Fonte: http://www.noteplace.com.br/artigo/memoria-ram-e-sua-influencia-sobre-o-desempenho-do-computador

Em relação à memória em um computador, é correto afirmar que:',2,1),

('Quais fatores são levados em consideração em relação ao tempo para leitura e gravação de um bloco de dados, no caso de discos magnéticos?

',2,2),
('Nos sistemas operacionais mais antigos que usavam fitas magnéticas para gravação, o tipo de organização de arquivos utilizada era:

',2,2),
('Relacione o tipo de dispositivo com sua função e em seguida escolha a alternativa correta:

( 1 ) Entrada.

( 2 ) Saída.

( 3 ) Entrada e Saída.

 

( ) Tela touch screen.

( ) Teclado e mouse.

( ) Impressora.',2,2),
('Vimos que a fragmentação pode deixar diversos espaços vazios em memória, os quais podem não ser suficientes para armazenar um determinado programa.

Qual estratégia permite que o programa seja alocado deixando o menor espaço possível sem utilização?',2,2),
('“O particionamento de disco, nada mais é do que dividir o HDD ou SSD de um PC em algumas partes. Além disso, é importante destacar que estas partes são divisões lógicas e não físicas.”

Fonte: https://sempreupdate.com.br/particionamento-de-disco-o-que-e-e-para-que-serve/. Acesso em 15 mai. 2021.

Em relação aos tipos de partições, elas podem ser:',2,2),
('Aprendemos que a memória tem grande importância para melhorar o desempenho no nosso computador. E uma das funções de um sistema operacional é gerenciar a memória. Dentre os tipos de memória que temos, qual é a memória que mantém os dados somente enquanto estamos utilizando? Ou seja, se o computador desligar, podemos perder tudo que está alocado nela.',2,2),
('Os tipos de sistemas de arquivo do Windows são:',2,2),
('Qual das técnicas usadas no gerenciamento de memória que divide o espaço de endereçamento virtual em blocos de tamanhos diferentes?

',2,2),
('A técnica que mantém uma área em disco reservada pela gerência de memória e quando é necessário um processo é copiado para o disco, chama-se:

',2,2),
('A memória pode ser dividida em memória primária ou principal e memória secundária. Um exemplo de memória secundária seria:

',2,2),

('O sistema operacional para dispositivos móveis da Apple, o iOS, é derivado de qual sistema?

',2,3),
('O sistema operacional iOS, para dispositivos móveis da Apple, é dividido em 4 camadas, sendo elas:

',2,3),
('Dos sistemas operacionais estudados, qual deles é o mais utilizado no mundo em computadores pessoais?

',2,3),
('No sistema operacional Windows, a sigla NTFS - NT File System, se refere a:

',2,3),
('Vimos que uma thread pode estar em um dos seis estados estudados. O estado em que ela é selecionada pelo escalonador e aguarda o chaveamento de contexto, é chamado:

',2,3),
('Dentre os sistemas operacionais utilizados atualmente, qual é o mais usado em dispositivos móveis, mais especificamente, em smartphones?

',2,3),
('A capacidade de um computador configurar e reconhecer, por meio de seu sistema operacional, automaticamente um dispositivo quando conectado, é chamado de:

',2,3),
('Cada sistema operacional possui suas características próprias, além de algumas, é claro, serem semelhantes. No comparativo entre o Windows e o Linux, uma de suas diferenças é:

',2,3),
('Para gerar maior segurança nos dados e informações armazenados, podemos realizar o controle de acesso dos usuários por meio de login como administrador de sistemas, porém isso pode causar vulnerabilidades no sistema:

',2,3),
('Em qual dos sistemas operacionais estudados que os dispositivos de entrada e saída (E/S), se parecem com arquivos?

',2,3),

('Quais as dimensões dos hipervisores?

',2,4),
('Uma máquina virtual (VM) pode ser definida como:

',2,4),
('Conhecemos algumas vantagens em utilizar a virtualização de sistemas operacionais. Uma delas é:

',2,4),
('São consideradas desvantagens na utilização de máquinas virtuais:

I – O isolamento permite sempre compartilhar todos os tipos de recursos.

II – As máquinas virtuais são mais seguras que as máquinas físicas.

III – No caso de custos de manutenção e treinamento, podem surgir alguns que não estavam previstos.

Assinale a alternativa correta:',2,4),
('O conceito que permite que um usuário possa se comunicar de forma fácil com o sistema operacional, executando diversas tarefas, é:

',2,4),
('Podemos considerar como arquiteturas de sistemas operacionais:

',2,4),
('Os sistemas operacionais são compostos por rotinas e estas são chamadas de:

',2,4),
('Sobre nossos estudos a respeito das máquinas virtuais (VM), marque V (verdadeiro) ou F (falso).

( ) Uma máquina virtual executa diversos processos.

( ) Uma máquina virtual de sistema existe de maneira temporária.

( ) Um hóspede pode ser um processo executado sobre uma VM.

( ) Um convidado é a plataforma onde a VM é executada.

Assinale a alternativa correta:',2,4),
('Sobre os atributos compartilhados entre as máquinas virtuais, assinale V (verdadeiro) ou F (falso):

( ) O atributo compatibilidade de software significa que o software desenvolvido para uma determinada máquina irá funcionar.

( ) O atributo desempenho pode ser alterado ao se colocar mais uma camada de software.

( ) O atributo isolamento não permite que os softwares sejam executados de forma isolada em diferentes máquina virtuais.

( ) O atributo encapsulamento se refere à manipulação e ao controle da execução de softwares em diferentes máquinas virtuais.',2,4),
('O hipervisor ou sistema operacional hospedeiro de uma máquina virtual, também é chamado de:

',2,4);

INSERT INTO answer_option (question_id, text, is_correct) VALUES

(1,'ONU - A Organização das Nações Unidas.',FALSE),
(1,'OMC - A Organização Mundial do Comércio',FALSE),
(1,'APEC - Cooperação Econômica da Ásia e do Pacífico',FALSE),
(1,'Nafta - Acordo de Livre-Comércio da América do Norte',FALSE),
(1, 'OTAN - Organização do Tratado do Atlântico Norte.',TRUE),

(2, 'Modelo espiral.',FALSE),
(2, 'Modelo em cascata.',FALSE),
(2, 'Modelo de prototipação.',FALSE),
(2, 'Modelo incremental.',TRUE),
(2, 'Modelo evolucionário.',FALSE),

(3, 'I, II, III e IV.',FALSE),
(3, 'I e III apenas.',TRUE),
(3, 'II e IV apenas.',FALSE),
(3, 'II, III e IV apenas.',FALSE),
(3, 'II e III apenas.',FALSE),

(4, 'I, II e III apenas.',FALSE),
(4, 'III, IV e V apenas.',FALSE),
(4, 'I, II, III, IV e V.',TRUE),
(4, 'II, IV e V apenas.',FALSE),
(4, 'II, III e IV apenas.',FALSE),

(5, 'Esta frase não representa a realidade da produção de software.',FALSE),
(5, 'Ainda estamos longe de resolver todos os problemas de software.',TRUE),
(5, 'Tal afirmação é apenas um caso isolado, sem grande impacto para a engenharia de software.',FALSE),
(5, 'A frase indica que estamos no caminho certo, a solução para os erros de software está prestes a ser encontrada.',FALSE),
(5, 'É uma frase de impacto, contudo a engenharia de software está muito além dos problemas ocasionados na produção de software.',FALSE),

(6, 'Trata de um esforço temporário empreendido para criar um produto, serviço ou resultado único.',FALSE),
(6, 'Diz respeito ao fim de um projeto que é alcançado quando os objetivos são atingidos ou quando o projeto é encerrado porque a necessidade do projeto deixa de existir.',FALSE),
(6, 'É a formalização entre as partes interessadas que estabelecem os acordos contratuais que irão reger todo desenvolvimento do projeto.',FALSE),
(6, 'É o emprego do conhecimento, das habilidades, de ferramentas e técnicas nas atividades relacionadas ao projeto, com o objetivo de atender aos seus requisitos.',TRUE),
(6, 'É um elemento essencial em tempos modernos; até podemos dizer que é o próprio avanço evolutivo da humanidade, não sendo mais possível desenvolver software sem alguns equipamentos tecnológicos.',FALSE),

(7, 'I, II, III e IV.',FALSE),
(7, 'I e II apenas.',FALSE),
(7, 'II, III e IV apenas.',FALSE),
(7, 'I e IV apenas.',FALSE),
(7, 'III e IV apenas.',TRUE),

(8, 'Deve ser pensado cuidadosamente no design e na implementação do projeto, pois o êxito do software depende fortemente desses dois elementos.',FALSE),
(8, 'A função do engenheiro é definir as responsabilidades, operações, atributos e associações de um conjunto de processos designados a ele.',FALSE),
(8, 'Engenharia de Software é a área da Computação que se preocupa em propor e aplicar princípios de engenharia na construção de software.',TRUE),
(8, 'A visão de sistema desse profissional é mais em extensão do que em profundidade.',FALSE),
(8, 'Em seu projeto é definida uma arquitetura com alto desempenho e baixo consumo de recursos. Ela possui um conjunto de instruções limpas e com características modular.',FALSE),

(9, 'Prototipação, Espiral e Incremental.',TRUE),
(9, 'Engenharia de software, arquitetura de software e Design de software.',FALSE),
(9, 'ProjectLibre, LibrePlan e Affero General Public License.',FALSE),
(9, 'Requisitos, gestão e produto de software.',FALSE),
(9, 'Gantt, Pert e caminho crítico.',FALSE),

(10, 'Todos são pontos cruciais..',TRUE),
(10, 'Apenas I, II, III e IV são pontos cruciais.',FALSE),
(10, 'Apenas IV, V e VI são pontos cruciais.',FALSE),
(10, 'Apenas I, III, V e VI são pontos cruciais.',FALSE),
(10, 'Nenhum dos itens são pontos cruciais.',FALSE),

(11,'Esta frase não representa a realidade da produção de software.',FALSE),
(11,'Ainda estamos longe de resolver todos os problemas de software.',TRUE),
(11,'Tal afirmação é apenas um caso isolado, sem grande impacto para a engenharia de software.',FALSE),
(11,'A frase indica que estamos no caminho certo, a solução para os erros de software está prestes a ser encontrada.',FALSE),
(11,'É uma frase de impacto, contudo a engenharia de software está muito além dos problemas ocasionados na produção de software.',FALSE),

(12,'Apenas I.',FALSE),
(12,'I, II e III.',TRUE),
(12,'Apenas I e II.',FALSE),
(12,'Apenas I e III.',FALSE),
(12,'Apenas III.',FALSE),

(13,'Normalmente, exige poucos recursos de memória. Sem exigir o acoplamento de periféricos, trabalham com severas restrições de consumo de energia, tempo de processamento e de espaço.',TRUE),
(13,'É um programa de computador e a sua documentação associada e o seu produto pode ser desenvolvido tanto para um único cliente ou para o mercado de maneira geral.',FALSE),
(13,'Trata sobre os primeiro programas de computador que por muito tempo foram feitas por meio de cartões perfurados.
',FALSE),
(13,'Sendo uma máquina composta de componentes eletrônicos, sua capacidade consiste em coletar, manipular e fornecer como resultados informações para os mais variados propósitos.',FALSE),
(13,'É um conjunto de elementos concretos ou abstratos que se interligam para formar um todo organizado. Mesmo sendo interdependentes têm funções específicas, contudo interagem entre si de forma harmônica para alcançar um objetivo comum.',FALSE),

(14,'I apenas.',FALSE),
(14,'II apenas.',FALSE),
(14,'III apenas.',FALSE),
(14,'I e III apenas.',FALSE),
(14,'I, II e III',TRUE),

(15,'Os leitores de cartão eram grandes máquinas eletrônicas com poucas instruções implementadas em hardware sendo seu circuito lógico digital difícil de entender e pouco confiável por conta da baixa estabilidade de suas válvulas.',FALSE),
(15,'Por existirem muitas linguagens de programação era inviável empregar uma delas no computador, para resolver esse problema, os cartões perfurados foram desenvolvidos.',FALSE),
(15,'Seu propósito é que o conjunto de instruções possa ser usado por pessoas que tenham o interesse em desenvolver ou modificar uma arquitetura de forma que possa ser integrada a qualquer computador.',FALSE),
(15,'Os primeiros cartões perfurados foram usados para processamento de dados pela IBM. Esses cartões eram perfurados em uma máquina própria para esta finalidade e, posteriormente, lidos em outro dispositivo, um leitor de cartão ligado ao computador.',TRUE),
(15,'Grande parte dos problemas eram por causa dos cartões perfurados. Não existindo critérios para desenvolver os programas de computador, tudo era feito de acordo com a necessidade e a capacidade técnica do programador.',FALSE),

(16,'As afirmações I e II são verdadeiras, e a II é uma justificativa correta da I.',FALSE),
(16,'As afirmações I e II são verdadeiras, mas a II não é uma justificativa correta da I.',FALSE),
(16,'A afirmação I é uma proposição verdadeira e a II é uma proposição falsa.',TRUE),
(16,'A afirmação I é uma proposição falsa e a II é uma proposição verdadeira.',FALSE),
(16,'As afirmações I e II são falsas.',FALSE),

(17,'Deve ser pensado cuidadosamente no design e na implementação do projeto, pois o êxito do software depende fortemente desses dois elementos.',FALSE),
(17,'A função do engenheiro é definir as responsabilidades, operações, atributos e associações de um conjunto de processos designados a ele.',FALSE),
(17,'Engenharia de Software é a área da Computação que se preocupa em propor e aplicar princípios de engenharia na construção de software.',TRUE),
(17,'A visão de sistema desse profissional é mais em extensão do que em profundidade.',FALSE),
(17,'Em seu projeto é definida uma arquitetura com alto desempenho e baixo consumo de recursos. Ela possui um conjunto de instruções limpas e com características modular.',FALSE),

(18,'Todos são pontos cruciais.',TRUE),
(18,'Apenas I, II, III e IV são pontos cruciais.',FALSE),
(18,'Apenas IV, V e VI são pontos cruciais.',FALSE),
(18,'Apenas I, III, V e VI são pontos cruciais.',FALSE),
(18,'Nenhum dos itens são pontos cruciais.',FALSE),

(19,'Prototipação, Espiral e Incremental.',TRUE),
(19,'Engenharia de software, arquitetura de software e Design de software.',FALSE),
(19,'ProjectLibre, LibrePlan e Affero General Public License.',FALSE),
(19,'Requisitos, gestão e produto de software.',FALSE),
(19,'Gantt, Pert e caminho crítico.',FALSE),

(20,'Modelo espiral.',FALSE),
(20,'Modelo em cascata.',FALSE),
(20,'Modelo de prototipação.',FALSE),
(20,'Modelo incremental.',TRUE),
(20,'Modelo evolucionário.',FALSE),

(21,'I apenas é razão para a manutenção de software.',FALSE),
(21,'III e IV apenas são razões para a manutenção de software.',FALSE),
(21,'I, II, III e IV são razões para a manutenção de software.',TRUE),
(21,'II, III e IV apenas são razões para a manutenção de software.',FALSE),
(21,'I e II apenas são razões para a manutenção de software.',FALSE),

(22,'Os testes têm a função de controle de qualidade e seu maior propósito é detectar erros.',TRUE),
(22,'Testes têm a função de detectar a presença de erros em um sistema.',FALSE),
(22,'Testes podem afirmar que um sistema está livre de erros.',FALSE),
(22,'Testes têm por função mostrar para o cliente que o sistema está 100% operacional.',FALSE),
(22,'Testes têm a função de demonstrar para os desenvolvedores onde eles estão errando no processo de codificação',FALSE),

(23,'IV apenas.',FALSE),
(23,'I, II e IV apenas.',TRUE),
(23,'I, II e III apenas.',FALSE),
(23,'I, II, III e IV.',FALSE),
(23,'III apenas.',FALSE),

(24,'Levantamento de requisitos.',TRUE),
(24,'Análise de dados.',FALSE),
(24,'Regra de negócio.',FALSE),
(24,'Engenharia de software.',FALSE),
(24,'Prototipação.',FALSE),

(25,'I apenas, pois a II não aborda corretamente o tema análise de requisitos.',FALSE),
(25,'II apenas, pois a I não aborda corretamente o tema análise de requisitos.',FALSE),
(25,'Nenhuma das afirmações aborda corretamente o tema análise de requisitos.',FALSE),
(25,'I e II, pois ambas tratam corretamente sobre análise de requisitos.',TRUE),
(25,'I e aborda parcialmente o tema análise de requisitos e II trata somente sobre o tema desenvolvimento de software.',FALSE),

(26,'As afirmações I e II são verdadeiras, e a II é uma justificativa correta da I.',TRUE),
(26,'As afirmações I e II são verdadeiras, mas a II não é uma justificativa correta da I.',FALSE),
(26,'A afirmação I é uma proposição verdadeira e a II é uma proposição falsa.',FALSE),
(26,'A afirmação I é uma proposição falsa e a II é uma proposição verdadeira.',FALSE),
(26,'As afirmações I e II são falsas.',FALSE),

(27,'Programação orientada a testes e teste de mesa.',FALSE),
(27,'Teste caixa-branca e teste caixa-preta.',TRUE),
(27,'Teste unitário, testes de segurança e teste de disponibilidade.',FALSE),
(27,'Teste de integração e testes de desempenho.',FALSE),
(27,'Teste de Sistema, teste de requisitos, teste de aceitação, teste beta e teste alfa.',FALSE),

(28,'Quando nos referimos a esse tipo de requisito estamos falando de suas características globais.',FALSE),
(28,'São princípios que as empresas adotam que ajudam os processos seguirem seu trâmite natural sem que haja paradas desnecessárias a cada situação semelhante que apareça.',FALSE),
(28,'Trata das tarefas e dos serviços que o software deve desempenhar. Eles vão definir a maneira que o sistema deve reagir conforme o que for inserido no sistema.',TRUE),
(28,'São restrições aos serviços ou funções oferecidas pelo sistema.',FALSE),
(28,'Expressa as definições ou restrições sobre algum ponto da estrutura ou comportamento da empresa.',FALSE),

(29,'Elicitação e levantamento de requisitos.',FALSE),
(29,'Elaboração e especificação.',FALSE),
(29,'Concepção e levantamento.',FALSE),
(29,'Avaliação e execução.',FALSE),
(29,'Requisitos de usuário e requisitos de sistema.',TRUE),

(30,'as definições da linguagem de programação escolhida para codificar o software.',FALSE),
(30,'as descrições do que o sistema deve fazer, os serviços que oferece e as restrições a seu funcionamento.',TRUE),
(30,'as fases da ideia de software que podem começar com uma conversa informal.',FALSE),
(30,'as definições de escopo do projeto.',FALSE),
(30,'as expressões das definições ou restrições sobre algum ponto da estrutura ou comportamento da empresa.',FALSE),

(31,'I apenas.',FALSE),
(31,'I e II apenas.',FALSE),
(31,'I, II e III apenas',FALSE),
(31,'IV apenas.',FALSE),
(31,'I, II, III, e IV',TRUE),

(32,'Herança – subclasses – superclasse – criar – subclasses – idênticos.',FALSE),
(32,'Polimorfismo – classes - superclasse - invocar - características – individuais e especializados.',TRUE),
(32,'Abstração – classes – filha – realizar – heranças – generalizados.',FALSE),
(32,'POO – métodos – abstração – invocar – especializações – generalizados.',FALSE),
(32,'Programação funcional – metodologias – função – invocar – herança – individuais.',FALSE),

(33,'Faz a restrição de acesso aos atributos, métodos ou a uma classe ocultando os detalhes da implementação ao usuário daquela classe.',FALSE),
(33,'Composta por objetos interativos ela mantêm seu próprio estado e pode ser entendida como entidade autônoma, pois inclui os dados e as operações que possibilitam serem manipulados.',FALSE),
(33,'De maneira geral, ela se concentra no entendimento dos requisitos assim como nos conceitos e operações relacionados com o software enfatizando o que deve ser feito.',FALSE),
(33,'Na busca por melhores formas de converter o mundo real em linguagem de computador ela se consolidou trazendo uma nova visão sobre a forma de programar sistemas computacionais.',FALSE),
(33,'É um princípio antigo na engenharia de software e com o uso dela é que são descritos os elementos nas linguagens de nível mais alto. ',TRUE),

(34,'I, II, III e IV.',FALSE),
(34,'II apenas.',FALSE),
(34,'IV apenas.',FALSE),
(34,'I e IV apenas.',FALSE),
(34,'Nenhuma das Alternativas.',TRUE),

(35,'Métrica de atuação e métrica metodológica.',FALSE),
(35,'Métricas de receita e métrica de retorno sobre o investimento.',FALSE),
(35,'Métrica de controle e métrica de previsão.',TRUE),
(35,'Métricas de atração e métricas de conversão.',FALSE),
(35,'Métrica de custo de aquisição e métrica de tempo de vida.',FALSE),

(36,'São usados para medir o desempenho funcional dos colaborares.',FALSE),
(36,'Empregados para melhorar o nível de maturidade de processo.',FALSE),
(36,'Usados para medir a produtividade do sistema.',FALSE),
(36,'Seus resultados são usados para adaptação da continuidade de trabalho no projeto e para as atividades técnicas.',TRUE),
(36,'Serve para avaliar o nível de aceitação do sistema em um nicho de mercado.',FALSE),

(37,'É usada para a medição da qualidade de software.',FALSE),
(37,'É usada para fins estratégicos na organização.',TRUE),
(37,'Empregada para medir o grau de satisfação do usuário.',FALSE),
(37,'Usada para calcular o número de linhas de código de um sistema.',FALSE),
(37,'Usada para coagir e intimidar funcionários de baixa produtividade.',FALSE),

(38,'I e II estão com as definições trocadas.',TRUE),
(38,'I está correta e II está errada.',FALSE),
(38,'I está errada e II está correta.',FALSE),
(38,'I e II estão corretas.',FALSE),
(38,'I e II não são definições para especialização e generalização.',FALSE),

(39,'3/B – 2/C – 1/A.',FALSE),
(39,'1/A – 2/B – 3/C.',FALSE),
(39,'2/A – 1/B – 3/C.',FALSE),
(39,'1/B – 3/A – 2/C.',FALSE),
(39,'3/B – 2/A – 1/C.',TRUE),

(40,'I, III e IV apenas.',TRUE),
(40,'I, II, III e IV.',FALSE),
(40,'I, II e III apenas.',FALSE),
(40,'II apenas.',FALSE),
(40,'II, III e IV apenas.',FALSE),

(41,'F, F, V.',TRUE),
(41,'F, F, F.',FALSE),
(41,'F, V, F.',FALSE),
(41,'V, F, V.',FALSE),
(41,'V, V, F.',FALSE),

(42,'Ele não afeta os outros processos em execução.',FALSE),
(42,'Ele não pode compartilhar dados com outros processos.',FALSE),
(42,'Ele pode compartilhar dados com outros processos, mas não pode afetar esses processos.',FALSE),
(42,'Ele pode afetar outros processos, mas não pode ser afetado por eles.',FALSE),
(42,'Ele pode afetar e ser afetado por outros processos.',TRUE),

(43,'Um conjunto de rotinas que permite controlar um computador ou dispositivo móvel.',TRUE),
(43,'Um sistema composto pela combinação de hardware e software.',FALSE),
(43,'Um tipo de software aplicativo.',FALSE),
(43,'Um software criado especialmente para o gerenciamento de redes de internet.',FALSE),
(43,'Um dispositivo físico que permite conectar a memória à CPU.',FALSE),

(44,'Sistemas batch, multitarefas e tempo real.',FALSE),
(44,'Primário e secundário.',FALSE),
(44,'Sistemas batch, de tempo compartilhado e exceções.',FALSE),
(44,'Sistemas batch, de tempo compartilhado e tempo real.',TRUE),
(44,'Sistemas computacionais, de tempo compartilhado e tempo real.',FALSE),

(45,'I e II, apenas.',FALSE),
(45,'I, II e III.',FALSE),
(45,'I, apenas.',FALSE),
(45,'II e III, apenas.',TRUE),
(45,'I e III, apenas',FALSE),

(46,'II e IV, apenas.',TRUE),
(46,'II e III, apenas.',FALSE),
(46,'I, apenas.',FALSE),
(46,'I, II e IV, apenas',FALSE),
(46,'I, II, III e IV.',FALSE),

(47,'Um sistema computacional permite que um computador seja inicializado.',FALSE),
(47,'Um sistema computacional é formado por um firmware e um peopleware.',FALSE),
(47,'Os sistemas computacionais são compostos por um hardware que processa informações de acordo com as instruções de um software.',TRUE),
(47,'Os sistemas computacionais atualmente só funcionam quando estão conectados via internet.',FALSE),
(47,'Os sistemas computacionais permitem que os usuários acessem uma rede de computadores a partir de uma conexão segura.',FALSE),

(48,'Tanto as interrupções quanto as exceções, ocorrem devido a um evento síncrono ao executar um programa.',FALSE),
(48,'As interrupções permitem interromper um programa em execução, mas as exceções não influenciam na execução do programa.',FALSE),
(48,'As interrupções são causadas por um evento interno do programa em execução e as exceções por um evento externo.',FALSE),
(48,'Apenas as exceções forçam a parada de execução de um programa, pois as interrupções não estão relacionadas a estes eventos.',FALSE),
(48,'As interrupções são causadas por um evento externo ao programa que está sendo executado e as exceções são geradas por um evento síncrono, direto da execução do programa.',TRUE),

(49,'Processos dependentes, subprocessos e threads.',FALSE),
(49,'Processos independentes, subprocessos e threads.',TRUE),
(49,'Processos independentes, processos dependentes e threads.',FALSE),
(49,'Subprocessos, kernel e threads.',FALSE),
(49,'Processos primários, processos secundários e threads.',FALSE),

(50,'A memória primária armazena os dados de forma permanente.',FALSE),
(50,'O HD (disco rígido) é um exemplo de memória primária.',FALSE),
(50,'A memória RAM é um exemplo de memória secundária e mantém os dados armazenados permanentemente.',FALSE),
(50,'A memória principal ou memória primária é volátil.',TRUE),
(50,'O pendrive pode ser considerado tanto memória primária quanto secundária.',FALSE),

(51,'Tempos de seek, latência principal e transferência.',FALSE),
(51,'Tempos de rotação, latência rotacional e transferência.',FALSE),
(51,'Tempos de seek, latência rotacional e transferência.',TRUE),
(51,'Latência rotacional, transferência e realocação.',FALSE),
(51,'Latência primária, transferência e realocação.',FALSE),

(52,'Secundário',FALSE),
(52,'Sequencial',TRUE),
(52,'Primário',FALSE),
(52,'Relativo',FALSE),
(52,'Indexado',FALSE),

(53,'3, 1, 2.',TRUE),
(53,'3, 2, 1.',FALSE),
(53,'2, 1, 3.',FALSE),
(53,'2, 3, 1.',FALSE),
(53,'1, 3, 2.',FALSE),

(54,'Worst-fit.',FALSE),
(54,'First-fit.',FALSE),
(54,'Best-fit.',TRUE),
(54,'One-fit.',FALSE),
(54,'Work-fit.',FALSE),

(55,'Volátil ou não volátil.',FALSE),
(55,'Principal ou secundária.',FALSE),
(55,'Primária ou secundária.',FALSE),
(55,'Fixa ou permanente.',FALSE),
(55,'Fixa ou variável.',TRUE),

(56,'RAM.',TRUE),
(56,'ROM',FALSE),
(56,'EPROM',FALSE),
(56,'ERAM',FALSE),
(56,'EAROM.',FALSE),

(57,'FAT e NTFS.',TRUE),
(57,'FAT e NIT.',FALSE),
(57,'BIOS e NTFS.',FALSE),
(57,'RAM e ROM.',FALSE),
(57,'BIOS e CACHE.',FALSE),

(58,'Paginação',FALSE),
(58,'Swapping.',FALSE),
(58,'Partições.',FALSE),
(58,'Segmentação.',TRUE),
(58,'Realocação',FALSE),

(59,'Substituição',FALSE),
(59,'Realocação.',FALSE),
(59,'Segmentação',FALSE),
(59,'Swapping',TRUE),
(59,'Paginação',FALSE),

(60,'RAM',FALSE),
(60,'HD (Hard Disk).',TRUE),
(60,'Cache',FALSE),
(60,'CPU',FALSE),
(60,'BIOS',FALSE),

(61,'Linux',FALSE),
(61,'Mac OSX.',TRUE),
(61,'Android',FALSE),
(61,'z/OS.',FALSE),
(61,'x/OS.',FALSE),

(62,'Core OS, Core Services, Media e Cocoa Touch.',TRUE),
(62,'Applications, Application Framework, Libraries e Linux Kernel.',FALSE),
(62,'Cupcake, Donut, Eclair e Froyo.',FALSE),
(62,'Core OS, Core Services, Media e Core Duo.',FALSE),
(62,'Applications, Framework, Libraries e Media.',FALSE),

(63,'Linux',FALSE),
(63,'Unix.',FALSE),
(63,'Android.',FALSE),
(63,'iOS',FALSE),
(63,'Windows',TRUE),

(64,'Sistema de arquivos.',TRUE),
(64,'Gerenciamento de memória.',FALSE),
(64,'Sistema de backup.',FALSE),
(64,'Inicialização do sistema.',FALSE),
(64,'Sistema de processamento.',FALSE),

(65,'Sleep.',FALSE),
(65,'Transition',FALSE),
(65,'Waiting.',FALSE),
(65,'Ready.',FALSE),
(65,'Standby.',TRUE),

(66,'Android',TRUE),
(66,'iOS',FALSE),
(66,'Windows 10.',FALSE),
(66,'Mac OSX.',FALSE),
(66,'MS-DOS.',FALSE),

(67,'Big Sur.',FALSE),
(67,'NTFS',FALSE),
(67,'Cocoa Touch.',FALSE),
(67,'Plug and play.',TRUE),
(67,'Thread',FALSE),

(68,'O Windows é um sistema de código aberto gratuito e Linux é um sistema de código fechado.',FALSE),
(68,'O Windows pode ser utilizado em computadores com o sistema Mac OS e o Linux não pode ser utilizado, neste caso.',FALSE),
(68,'O Windows é um sistema comercial pago e o Linux é gratuito.',TRUE),
(68,'O Windows é um sistema multitarefas enquanto o Linux é monotarefa.',FALSE),
(68,'O Windows possui apenas o conceito de processos e o Linux de threads.',FALSE),

(69,'Windows.',TRUE),
(69,'Linux.',FALSE),
(69,'Android.',FALSE),
(69,'iOS.',FALSE),
(69,'z/OS.',FALSE),

(70,'iOS',FALSE),
(70,'Mac OS.',FALSE),
(70,'Linux.',TRUE),
(70,'Unix',FALSE),
(70,'Windows',FALSE),

(71,'Segurança, facilidade e eficiência.',FALSE),
(71,'Eficácia, fidelidade e acurácia.',FALSE),
(71,'Confiabilidade, fidelidade e eficiência.',FALSE),
(71,'Conformidade, segurança e eficiência.',FALSE),
(71,'Segurança, fidelidade e eficiência.',TRUE),

(72,'Um nível entre o hardware que está numa camada de nível mais baixo e o sistema operacional.',TRUE),
(72,'Um nível entre o software que está numa camada de nível mais baixo e o sistema operacional.',FALSE),
(72,'Um nível entre o hardware que está numa camada de nível mais alto e o sistema operacional.',FALSE),
(72,'Um computador ou estação de trabalho disponível em uma rede local.',FALSE),
(72,'Uma aplicação disponível na rede interna da organização.',FALSE),

(73,'Deixar apenas o Windows como sistema operacional nas máquinas virtualizadas.',FALSE),
(73,'É possível compartilhar apenas dispositivos de rede.',FALSE),
(73,'Permite virtualizar somente sistemas operacionais monotarefa.',FALSE),
(73,'É possível compartilhar o mesmo hardware, executando sistemas operacionais diferentes de maneira concorrente.',TRUE),
(73,'Compartilha o sistema operacional na nuvem com todos os usuários de fora da empresa.',FALSE),

(74,'Todas as afirmativas estão corretas.',FALSE),
(74,'Somente a alternativa I está correta.',FALSE),
(74,'Somente as alternativas I e II estão corretas.',FALSE),
(74,'Somente as alternativas II e III estão corretas.',FALSE),
(74,'Somente a afirmativa III está correta.',TRUE),

(75,'Linguagem operacional.',FALSE),
(75,'Linguagem de sistema.',FALSE),
(75,'Linguagem de comando.',TRUE),
(75,'Linguagem híbrida.',FALSE),
(75,'Linguagem de programação.',FALSE),

(76,'Monolítica, microkernel, híbrida e de camadas.',FALSE),
(76,'Modular, híbrida, máquina virtual e microkernel.',FALSE),
(76,'Monolítica, scripts, máquina virtual e kernel.',FALSE),
(76,'Monolítica, de camadas, máquina virtual e microkernel.',TRUE),
(76,'Modular, de camadas, máquina virtual e kernel.',FALSE),

(77,'Script',FALSE),
(77,'Kernel',TRUE),
(77,'Shell',FALSE),
(77,'Interrupções',FALSE),
(77,'Processos.',FALSE),

(78,'V, F, V, F.',TRUE),
(78,'V, V, F, F.',FALSE),
(78,'V, F, V, V.',FALSE),
(78,'F, V, F, F.',FALSE),
(78,'F, V, V, V.',FALSE),

(79,'V, V, F, V.',TRUE),
(79,'V, V, V, V.',FALSE),
(79,'F, V, F, V.',FALSE),
(79,'F, V, V, V.',FALSE),
(79,'V, F, V, V.',FALSE),

(80,'Sistema Operacional Móvel.',FALSE),
(80,'Monitor de Sistema Virtual.',FALSE),
(80,'Monitor de Máquina Virtual.',TRUE),
(80,'Monitor de Virtualização.',FALSE),
(80,'Sistema de Máquina Virtual.',FALSE);