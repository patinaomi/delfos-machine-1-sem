# Prevenção Odontológica Inteligente com Agenda Eletrônica

## Objetivo Geral do Projeto
Desenvolver um modelo de inteligência artificial que analise informações do banco de dados, alimentadas por formulários de cadastro, 
consultas agendadas periodicamente e feedbacks recebidos (seja do cliente, da consulta ou do consultório). O principal objetivo é fornecer 
recomendações personalizadas de serviços preventivos odontológicos por meio de uma agenda inteligente e automatizada, visando reduzir a 
sinistralidade e melhorar a saúde bucal dos clientes.

## Resumo dos objetivos específicos
Ao cadastrar um novo cliente, será enviado um formulário detalhado por e-mail ou disponibilizado no aplicativo. Este formulário fará 
perguntas sobre a rotina do cliente e os cuidados realizados nos últimos meses ou anos. Com base nas respostas, o sistema sugerirá 
serviços preventivos e identificará consultórios próximos, oferecendo opções que combinem baixo custo e alta qualidade, conforme avaliações de 
pesquisas de ambos os lados, especialmente das clínicas. O foco é garantir que os atendimentos sejam acessíveis, mas com qualidade garantida.

Além disso, o sistema agendará automaticamente a consulta na clínica escolhida, priorizando aquelas mais próximas ao cliente, conforme sua localização. 
Esse processo não requer intervenção do cliente para realizar a pesquisa; ele apenas precisará aceitar a sugestão. Com antecedência, mensagens serão 
enviadas via WhatsApp e e-mail, além de notificações no aplicativo, lembrando o cliente sobre a consulta e orientando sobre os preparativos necessários.

Aproveitando os dados coletados, o modelo também avaliará os próximos passos do atendimento, identificando consultas adicionais que o 
cliente possa precisar e enviando sugestões relevantes. A ideia é criar uma experiência única para o cliente, prevendo cada passo e necessidade, 
evitando que ele precise abrir atendimentos emergenciais sem a devida prevenção.

# Escopo detalhado do processo e que precisa ser inserido no Azure Devops

## Principal

**Aplicativo com Agenda Digital:** Desenvolvimento de um aplicativo com uma agenda eletrônica que faça os agendamentos automatizados, lembre os usuários 
sobre consultas e cuidados diários, além de oferecer dicas personalizadas para a saúde bucal.
**Cadastro de Clientes:** Criar um site e aplicativo para o cadastro de clientes.

## Secundários

**Formulário Detalhado:** Desenvolver um formulário que colete informações abrangentes sobre a rotina e saúde bucal do cliente. Esse 
formulário deve incluir perguntas sobre trabalho, estudo, cuidados familiares e preferências de horários para exames, permitindo agendamentos 
automáticos de acordo com a disponibilidade do cliente, como agendar consultas para o final de semana, se necessário.

**Página de Agenda:** Implementar uma página dedicada à agenda, exibindo as atividades que o cliente precisa realizar, com horários, 
nomes, descrições e períodos. Este modelo funcionará de forma semelhante à "Alexa tarefas", oferecendo lembretes automáticos e personalizados desses agendamentos.

**Base de Clínicas:** Criar um fluxo para coletar as avaliações das clinicas (Avaliar até o Google e formulários internos que serão preenchidos). Isso permitirá 
identificar as opções mais bem avaliadas e podemos cruzar com os custos.

**Modelo de IA para Recomendações:** Desenvolver um modelo de inteligência artificial que analise as informações do banco de dados e forneça 
recomendações de serviços preventivos odontológicos.

**Sistema de Notificação Eletrônica:** Criar um sistema automatizado para notificar os clientes sobre os próximos passos e cuidados necessários. Atualmente, 
a Espaço Leaser tem uma agendae também avisa o cliente só por e-mail mas em cima da hora. O novo sistema será mais dinâmico e funcional.

**Integração com Banco de Dados:** Integrar o sistema com o banco de dados para coletar e analisar informações de pacientes, médicos, clínicas e 
rotinas familiares. Considerar também a possibilidade de verificar processos judiciais abertos, abordando potenciais fraudes.

## Terceira Parte
**Análise Preditiva para Fraude:** Utilizar machine learning para prever quais usuários têm maior probabilidade de abrir sinistros, permitindo ações proativas.

**Análise de Comportamento dos Clientes:** Utilizar dados históricos para identificar usuários com alta frequência de sinistros, analisando perfil 
demográfico, histórico de uso e tipos de procedimentos para entender padrões.

**Segmentação de Usuários:** Implementar um modelo de classificação para categorizar usuários em grupos (ex: alto, médio e baixo risco) e 
direcionar ações de forma mais eficaz.

## Educação, Incentivos e Conscientização

**Campanhas Educacionais:** Desenvolver materiais informativos sobre cuidados dentários e a importância da prevenção, incluindo vídeos, blogs e newsletters.

**Vídeos no App:** Realizar eventos online sobre saúde bucal, abordando temas de prevenção. Como alternativa às consultas, direcionar os 
clientes a assistir vídeos educacionais a cada atendimento. Se assistir esses vídeos, ele vai pontuar no programa de relacionamento, igual o modelo do Banco Itaú.

**Programas de Incentivo:** Criar um sistema de recompensas para usuários que realizam consultas regulares e tratamentos preventivos, como limpeza e 
check-ups. Também oferecer descontos em procedimentos preventivos para incentivar o uso de serviços odontológicos antes que problemas maiores surjam. Os clientes
poderão acumular pontos por atividades sugeridas, que podem resultar em descontos de até 15% na próxima mensalidade. Esse modelo será baseado em um modelo utilizado 
pelo banco Itaú.

# Descrição do Problema a Resolver

A sinistralidade nas empresas de odontologia é elevada, em grande parte devido à falta de prevenção e cuidados regulares. Nosso objetivo é garantir que os clientes tenham seus atendimentos básicos agendados automaticamente, reduzindo assim gastos excessivos. A agenda pode incluir vídeos ou jogos educativos que os clientes possam realizar em apenas dez minutos, abordando cuidados com os dentes, gengivas e maxilares, promovendo uma conscientização mais efetiva e além de pontuar no programa de relacionamento.

Muitos clientes não têm acesso a informações personalizadas sobre serviços preventivos odontológicos, o que agrava a situação. A ausência de cuidados preventivos pode resultar em problemas mais sérios e dispendiosos, tanto para os clientes quanto para as empresas.

As empresas de odontologia também enfrentam perdas financeiras devido a procedimentos desnecessários e caros, que poderiam ser evitados com uma abordagem proativa e educativa. Portanto, é fundamental implementar soluções que promovam a prevenção e o acesso a informações relevantes, beneficiando tanto os clientes quanto as empresas. No final, eles podem ter acesso a essa base de informações e utilizar em programas de contratação e motivação de seus colaboradores.

# Descrição dos Objetivos da Solução Idealizada

1. Reduzir a sinistralidade em empresas de odontologia; 
2. Fornecer recomendações personalizadas de serviços preventivos odontológicos para os clientes; 
3. Melhorar a saúde bucal dos clientes; 
4. Reduzir os custos para as empresas de odontologia e os clientes. Neste modelos estamos falando em reduzir e não em evitar. Por isso nosso modelo pode atender, pois o cliente fará todos os serviços básicos, pois iremos fornecer todos as informações necessárias, sem esperar que ele entre em contato e nos acione, causando maiores prejuízos.

# Definição do Público Alvo

1. Clientes de empresas de odontologia que buscam prevenção e cuidados regulares. Aqui estou falando do público alvo final e não de empresas. Para as empresas, podemos gerar uma agenda com todas as consultas que forma utilizadas pelos clientes, para mostrar que eles estão usando os serviços e os custos com eles, pois isso mostra que o investimento que eles fazem, tem valor e isso pode ajudar a empresa a divulgar ainda mais seus benefícios e diferenciais. Hoje poucas empresas tem esses dados, que podem ajudar também no controle de serviços ilícitos por exemplo e até mostrar que a pessoa pode se afastar se tiver um problema mais sério. 

2. Empresas de odontologia que buscam reduzir a sinistralidade e melhorar a saúde bucal dos clientes; 

3. Pessoas que buscam serviços preventivos odontológicos personalizados e acessíveis.

# Estudo de Produtos Semelhantes

Existem aplicativos e sites que oferecem serviços de prevenção odontológica, mas não são personalizados e não utilizam IA; Exemplo Espaço Leaser, outras que possuem o sistema de aviso como Alexa e Google Assistant quando programados, assim como os programas de beneficios do Itaú que são referência hoje. 

Alguns produtos oferecem serviços de agenda eletrônica, mas não estão integrados com o banco de dados; Espaço Leaser tem a agenda e até manda comunicado, mas isso de forma manual. 

Nenhum produto oferece uma solução completa e integrada como a proposta que estamos oferecendo. 

# Avaliação do Potencial de Mercado

1. O mercado de odontologia é grande e em crescimento; Precisamos dos números aqui, igual a Maria fez no challenge passado. 
2. A demanda por serviços preventivos odontológicos é alta; Como ele não irão mandar as bases, posso pegar da ANS. 

**Exemplo dos dados que foram coletados:**

```bash
  https://www.camara.leg.br/radio/programas/1074177-ans-divulga-dados-sobre-os-planos-de saude/#:~:text=Dados%20divulgados%20pela%20Ag%C3%AAncia%20Nacional,no%20ritmo%20pretendido%20pelas%20operadoras. 
```

Dados divulgados pela Agência Nacional de Saúde Suplementar mostram que o setor teve lucro líquido de R$ 3,3 bilhões nos primeiros três meses do ano. Em 2023, havia sido de R$ 1,2 bilhão. Para a ANS, os números revelam uma recuperação do setor, ainda que não no ritmo pretendido pelas operadoras. A divulgação acontece após várias notícias sobre cancelamento de planos de forma unilateral pelas operadoras. Elas alegavam justamente a necessidade de equilíbrio das contas. Para saber a situação do seu plano, basta acessar o Painel Econômico-Financeiro da Saúde Suplementar na página da ANS. 

```bash
  https://www.gov.br/ans/pt-br/acesso-a-informacao/perfil-do-setor/dados-e-indicadores-do-setor 
```

No Gov tem várias bases de dados que podemos usar para alimentar a IA. Nem precisamos de mais nada além disso. 

Os inserts que vamos fazer no banco, será com base em API: 

```bash
  https://www.ans.gov.br/anstabnet/cgi-bin/dh?dados/tabnet_cc.def 
```

Veja as tabelas no link acima, tem muita coisa. Então vamos bater um número de colunas consideravel. 

 

A solução proposta pode conquistar uma fatia significativa do mercado devido à sua inovação e eficácia. 

