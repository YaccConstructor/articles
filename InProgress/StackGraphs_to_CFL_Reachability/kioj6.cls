%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                      %%%
%%%    Document class for preparing an article for publication           %%%
%%%    in the Computer Tools in Education journal <info@ipo.spb.ru>,     %%%
%%%    http://cte.eltech.ru/ojs                                          %%%
%%%    using LaTeX2e                                                     %%%
%%%                                                                      %%%
%%%    Copyright (C) 2026 by the center for informatization of Education %%%
%%%                      "KIO", all rights reserved.                     %%%
%%%                                                                      %%%
%%%    This file can be redistributed and/or modified under the terms    %%%
%%%    of the LaTeX Project Public License (lppl).                       %%%
%%%                                                                      %%%
%%%    The work is based on the Style for the journal Condensed          %%%
%%%    Matter Physics (https://ctan.org/pkg/cmpj)                        %%%
%%%                                                                      %%%
%%%    Please report errors to: Maksim Subbotin                          %%%
%%%                             mosubbotin@etu.ru                        %%%
%%%                                                                      %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}

% А. Б. Иванов1,  должность, orcid (если есть)
% Б. П. Петров1,2,  должность, orcid (если есть)
% 1. Полное наименование организации, адрес, город, индекс, страна
% 2. Полное наименование организации, адрес, город, индекс, страна
% Цифры 1 и 2 - это верхние индексы, как у нас и было. Если автор один, индекс также нужен.
%
\RequirePackage{iftex}
\ProvidesClass{kioj6}[2026/04/07 The KIO and CAM journals class]
\def\filename{kioj6.cls}
\def\fileversion{5.00}
\def\filedate{2026/04/07}
\immediate\write32{This is '\filename' v\fileversion \space <\filedate> ^^J%
     the KIO and CTE journals class}
\newif\if@firstpage
\@firstpagetrue

\ifpdftex
	\RequirePackage{cmap} % pdf copy\paste + search package
\fi

%        Options       ====

%eqsecnum: new numbering of formulae in each section
\def\eqsecnum{%
        \@addtoreset{equation}{section} %
        \def\theequation{\ifnum \c@section>\z@ \thesection.\fi \@arabic\c@equation}%
}

\DeclareOption{eqsecnum}{\eqsecnum}

\DeclareOption{noimages}{\def\@noimages{}}

\newif\if@englishversion
\@englishversionfalse

% Открытый флаг (без @) — доступен из main.tex как \ifenglishpaper. Зеркалит \if@englishversion.
\newif\ifenglishpaper
\englishpaperfalse

\newcommand{\englishversion}{%
	\@englishversiontrue\englishpapertrue
	\renewcommand{\refname}{References}%
	\renewcommand{\bibname}{References}%
}
\newcommand{\russianversion}{%
	\@englishversionfalse\englishpaperfalse
	\renewcommand{\refname}{Список литературы}%
	\renewcommand{\bibname}{Список литературы}%
}

% Переключение языка отрисовки на противоположный (используется в translatedpart).
% Меняется ТОЛЬКО \if@englishversion (текущий контекст рендера).
% \ifenglishpaper остаётся равным выбранному пользователем языку статьи —
% это нужно колонтитулам, которые должны быть постоянны на всех страницах.
\def\@flip@englishversion{%
	\if@englishversion
		\@englishversionfalse
	\else
		\@englishversiontrue
	\fi
}

% font options

\def\kio@sf{cmss}

\def\lat@sf{\kio@sf}
\def\cyr@sf{\kio@sf}
\def\Hv@scale{0.889}
\def\Pr@scale{0.889}
\def\cmpj@sf{}

\def\cmpj@sf@helvet{
  %P%\IfFileExists{t1phv.fd}{
  \IfFileExists{t2aphv.fd}{
    \def\lat@sf{phv}
  }{
    \def\lat@sf{\kio@sf}
  }
  \IfFileExists{t2appr.fd}{
    \def\cyr@sf{ppr}
  }{
    \def\cyr@sf{\kio@sf}
  }
}

\def\cmpj@sf@droid{
\ifpdftex
\RequirePackage{fourier}
\fi
\ifxetex
\RequirePackage{fourier-otf}
\fi

%\RequirePackage{txfonts}
%\IfFileExists{omltxmi.fd}{\re@DeclareMathSymbol{\varkappa}{\mathord}{AMSb}{123}}{}
\RequirePackage[default,scale=0.86]{droidserif}
\RequirePackage[defaultsans,scale=0.86]{droidsans}
\RequirePackage[defaultmono,scale=0.86]{droidsansmono}
\def\lat@sf{droidsans}
\def\cyr@sf{droidsans}
}

\DeclareOption{droid}{\let\cmpj@sf\cmpj@sf@droid}

\DeclareOption{helvet}{\let\cmpj@sf\cmpj@sf@helvet}

\DeclareOption{cm}{\def\cmpj@sf{}}

%Two languages
% \@lang{<ru>}{<en>} и \@langrev — отдают вариант для текущего языка отрисовки.
% \if@englishversion инвертируется в \translatedpart, поэтому одна проверка покрывает все случаи.

\newcommand\@lang[2]{\if@englishversion#2\else#1\fi}
\newcommand\@langrev[2]{\if@englishversion#2\else#1\fi}
\newcommand\@unreverselang[1]{#1}

\DeclareOption{english}{
	\def\@english{}
	\@englishversiontrue
	\englishpapertrue
}
\DeclareOption{authorsinfo}{
    \def\need@authors@info{}
}

% nocopyright option

\def\@@copyright{\copyright}
\def\copyright@size{\small}
\def\copyright@author{\@author\cp@issue@year}
\def\copyright@journal{\@unreverselang{\copyright\space\MakeTextUppercase{\journal@type}. \textnumero\issue@number, \issue@year}\@lang{ \space г.}{}}
\def\authorcopyright{\@ifnextchar[
        \iauthorcopyright{\iauthorcopyright[\small]}}
\def\iauthorcopyright[#1]#2{\gdef\copyright@size{#1}
        \gdef\copyright@author{#2}}

\DeclareOption{nocopyright}{\def\@@copyright{}\authorcopyright{}}

% Forward unknown options to the underlying article class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ExecuteOptions{droid}

\ProcessOptions\relax

% Load article with our enforced defaults. Any options the user passed to
% \documentclass (e.g. eqsecnum, authorsinfo) that are NOT among the local
% options above were forwarded to article by \DeclareOption*.
\LoadClass[intlimits,twoside,a4paper,11pt]{article}

\ifpdftex
	\RequirePackage[T2A]{fontenc}
\fi
\@lang{
  \RequirePackage[english,russian]{babel}
}{
  \RequirePackage[russian,english]{babel}
}
\RequirePackage{fancyhdr}
\RequirePackage{graphicx}
\@ifundefined{@noimages}{}{\renewcommand{\includegraphics}[2][]{\fbox{\detokenize{#2}}}}  
\RequirePackage{ifthen}
\RequirePackage{textcase}
\RequirePackage{setspace}
\RequirePackage{varwidth}
\RequirePackage[pdfstartview=FitH,colorlinks=true,urlcolor=Blue,citecolor=Green,linkcolor=red]{hyperref}
\RequirePackage{url}
%\RequirePackage{doi}
\RequirePackage[dvipsnames]{xcolor}  %
\RequirePackage{float}
\RequirePackage[tableposition=top,labelfont={bf,sf,small},font=small,skip=4mm,labelsep=period]{caption}
\RequirePackage{subcaption}
\RequirePackage[misc]{ifsym}  
\RequirePackage{microtype}
\RequirePackage[resetlabels]{multibib}

\def\asbuk#1{\expandafter\@asbuk\csname c@#1\endcsname}
\def\@asbuk#1{\ifcase#1\or а\or б\or в\or г\or д\or е\or ё\or ж\or з\or и\or й\or к\or л\or м\or н\or о\or п\or р\or с\or т\or у\or ф\or х\or ц\or ч\or ш\or щ\or ъ\or ы\or ь\or э\or ю\or я\fi}

% Подписи рисунков, таблиц и нумерация подрисунков — выбираются по языку отрисовки.
\renewcommand\thesubfigure{\@lang{\asbuk{subfigure}}{\alph{subfigure}}}
\AtBeginDocument{%
	\renewcommand{\figurename}{\@lang{Рис.}{Fig.}}%
	\renewcommand{\tablename}{\@lang{Табл.}{Table}}%
}

\newcommand\kioabstractname{\@langrev{Аннотация}{Abstract}}
\newcommand\keywordsname{\@langrev{Ключевые слова}{Keywords}}
\newcommand\citationname{\@langrev{Цитирование}{Citation}}
\newcommand\acknowledgementsname{\@langrev{Благодарности}{Acknowledgements}}

\urlstyle{same}

\cmpj@sf

\def\hv@sf{\sffamily\upshape}

% remove lists spacing

\def\remove@lists@spacings{
  \let\oldenumerate\enumerate
  \renewcommand{\enumerate}{
    \oldenumerate
    \setlength{\itemsep}{0pt}
    \setlength{\parskip}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\topsep}{0pt}
    \setlength{\partopsep}{0pt}
  }

  \let\olditemize\itemize
  \renewcommand{\itemize}{
    \olditemize
    \setlength{\topsep}{0pt}
    \setlength{\itemsep}{0pt}
    \setlength{\parskip}{0pt}
    \setlength{\parsep}{0pt}
    \setlength{\partopsep}{0pt}
  }
}
\remove@lists@spacings

%%  Настройка заголовка  %%


\renewcommand\section{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\large\hv@sf\bfseries\mathversion{bold}\centering\MakeUppercase}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\large\hv@sf\bfseries\mathversion{bold}}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\hv@sf\bfseries\mathversion{bold}}}
\renewcommand\paragraph{\@startsection{paragraph}{4}{\z@}%
                                    {3.25ex \@plus1ex \@minus.2ex}%
                                    {-1em}%
                                    {\normalfont\normalsize\hv@sf\bfseries\mathversion{bold}}}
\renewcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {3.25ex \@plus1ex \@minus .2ex}%
                                       {-1em}%
                                      {\normalfont\normalsize\hv@sf\bfseries\mathversion{bold}}}

\def\@seccntformat#1{\csname the#1\endcsname.\hspace{0.5em}}

%% penalties

\widowpenalty=0
\clubpenalty=0
\emergencystretch=3em

\def\relax@with@arg#1{\relax}
\def\@affil#1{\textsuperscript{#1}}
\let\affil\@affil
\def\affiliation@footnotes{}
\def\affiliation#1#2{\g@addto@macro\affiliation@footnotes{
\textsuperscript{#1}#2\par
}}

% Английские аффилиации
\def\affiliationen#1#2{\g@addto@macro\affiliation@footnotes@en{
		\textsuperscript{#1}#2\par
}}

% Переменная для английских аффилиации
\def\affiliation@footnotes@en{}

%% Generic helpers for iterating over authors 1..10 (\author@i holds the index).

\def\@author@indices{1,2,3,4,5,6,7,8,9,10}

% \@authors@iter{<probe-suffix>}{<body>}: run <body> for every author<i><probe-suffix> that is defined.
\long\def\@authors@iter#1#2{%
	\@for\author@i:=\@author@indices\do{%
		\ifcsname author\author@i#1\endcsname#2\fi%
	}%
}

% Comma-separated list of \csname author<i><suffix>\endcsname.
% Expandable (safe inside \edef): walks indices 1..10 carrying the current separator.
\def\@authors@split@by@comma#1{\@authors@walk{1}{#1}{}}
\def\@authors@walk#1#2#3{%
	\ifnum#1>10 \else
		\@ifundefined{author#1#2}%
			{\expandafter\@authors@walk\expandafter{\the\numexpr#1+1\relax}{#2}{#3}}%
			{#3\csname author#1#2\endcsname\expandafter\@authors@walk\expandafter{\the\numexpr#1+1\relax}{#2}{, }}%
	\fi
}

\def\@authors@truncated#1#2#3#4{%
	\count@\z@
	\@authors@iter{#3}{\advance\count@\@ne}%
	\edef\@authors@truncated@total{\the\count@}%
	\ifnum\@authors@truncated@total>#1
		\@tempcnta#2\relax
	\else
		\@tempcnta\@authors@truncated@total\relax
	\fi
	\count@\z@\let\@author@sep\@empty
	\@authors@iter{#3}{%
		\advance\count@\@ne
		\ifnum\count@>\@tempcnta\else
			\@author@sep
			\csname author\author@i#3\endcsname
			\def\@author@sep{, }%
		\fi
	}%
	\ifnum\@authors@truncated@total>#1 #4\fi
}

\def\authors@short@split@by@comma{\@authors@split@by@comma{@short}}
\def\authors@short@first@lang@split@by@comma{\@authors@split@by@comma{@short@first@lang}}
\def\authors@short@first@lang@split@by@comma@remove@affil{%
\global\let\@@affil\affil%
\global\let\affil\relax@with@arg%
\authors@short@first@lang@split@by@comma%
\global\let\affil\@@affil%
}

\def\authors@short@en@split@by@comma{\@authors@split@by@comma{@short@en}}
\def\authors@short@truncated{\@authors@truncated{4}{3}{@short}{\ и~др.}}
\def\authors@short@en@truncated{\@authors@truncated{4}{3}{@short@en}{\ et al.}}

\def\@Letter{{\footnotesize \Letter}}  

%% Authors information
\def\authors@all@info{%
	\def\authorinfo##1{
		\setstretch{0.9}
		\if@englishversion
		\csname author##1@short@en\endcsname%
		\else
		\csname author##1@short\endcsname%
		\fi
		\ifcsname author##1@email\endcsname%
		\hspace{0.25em}%
		\ifcsname author##1@email@recepient\endcsname%
		\hspace{0.25em}\@Letter\ % <-- Добавлен пробел после конвертика
		\fi%
		\hspace{0.25em}\href{mailto:\csname author##1@email\endcsname}{\csname author##1@email\endcsname}%
		\fi
		\ifcsname author##1@orcid\endcsname%
		, \href{https://\csname author##1@orcid\endcsname}{\csname author##1@orcid\endcsname}%
		\fi
	}
	\@authors@iter{@short}{\authorinfo{\author@i}\par}%
}

%        Верхний колонтитул       

% Для русских авторов
\def\authors@names@only@ru{%
	\begingroup
	\def\affil##1{}%
	\@authors@truncated{4}{3}{@short}{\ и~др.}%
	\endgroup
}

% Для английских авторов
\def\authors@names@only@en{%
	\begingroup
	\def\affil##1{}%
	\ifcsname author1@short@en\endcsname
		\@authors@truncated{4}{3}{@short@en}{\ et al.}%
	\else
		\@authors@truncated{4}{3}{@short}{\ et al.}%
	\fi
	\endgroup
}
	

% Title

\newcommand\firstpage{\label{first@page}}
\newcommand\lastpage{\label{last@page}}

% Сноска без маркера на первой странице — выходные данные на «противоположном»
% языке (английская статья → русская сноска, русская статья → английская сноска).
% Три строки: авторы, полное название, журнал/год/номер/страницы.
\def\@firstpage@translation@citation{%
	\begingroup
		\def\@thefnmark{}%
		\def\@makefnmark{}%
		\long\def\@makefntext##1{\noindent##1}%
		\@footnotetext{%
			\if@englishversion
				% Английская статья → русская сноска.
				\temp@authors\\
				\@title.\\
				\copyright\ \journal@type@ru, \issue@year. № \issue@number. С. \pages@span.%
			\else
				% Русская статья → английская сноска.
				\temp@authors@en\\
				\@title@en.\\
				\copyright\ \journal@type@en, \issue@year. No \issue@number. P. \pages@span.%
			\fi
		}%
	\endgroup
}

\renewcommand\maketitle{\par
	\@firstpagetrue % Устанавливаем флаг первой страницы
	\gdef\@author{\mbox\authors@short@split@by@comma}

	\ifcsname fancy@title\endcsname
	\setarticleheader{\fancy@title}{\fancy@title@en}
	\else
	\setarticleheader{\@title}{\@title@en}
	\fi

	\gdef\temp@authors{\begingroup\let\affil\@gobble\authors@short@truncated\endgroup}
	\gdef\temp@authors@en{\begingroup\let\affil\@gobble\authors@short@en@truncated\endgroup}

	% разные авторы для русского и английского
	\setauthorsheader{\authors@names@only@ru}{\authors@names@only@en}

	\begingroup
	\renewcommand\thefootnote{\@fnsymbol\c@footnote}%
	\def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
	\long\def\@makefntext##1{\parindent 1em\noindent
		\hb@xt@1.8em{%
			\hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
	\global\@topnum\z@   % Prevents figures from going at top of page
    \@maketitle
	\@firstpage@translation@citation % выходные данные на противоположном языке
	\thispagestyle{firstpagestyle} % Специальный стиль для первой страницы
	\global\@firstpagefalse % Сбрасываем флаг
	\pagestyle{mainstyle} % Устанавливаем основной стиль для следующих страниц
	\@thanks
	\endgroup
	\setcounter{footnote}{0}%
%	\global\let\affil\relax@with@arg
	\global\let\thanks\relax
%	\global\let\maketitle\relax
	\global\let\@thanks\@empty
	\firstpage
	\@firstpagefalse % После создания титульной страницы сбрасываем флаг
}
  \setcounter{footnote}{0}%
 % \global\let\affil\relax@with@arg
  \global\let\thanks\relax
%  \global\let\maketitle\relax
  \global\let\@thanks\@empty
%  \firstpage

\def\@title{}
\def\@author{}
\def\@address{}
\def\fancy@header@title{FANCY@HEADER@TITLE}
\def\journal@type{}
\def\issue@year{????}%
\def\issue@number{?}%
\def\journal@section@img{kio-logo-col.png}
\def\journal@section@name{????}
\def\cp@issue@year{}
\expandafter\def\csname author1@short\endcsname{???}
\expandafter\def\csname author1@full\endcsname{????}
\expandafter\def\csname author1@addr\endcsname{??????}
\expandafter\def\csname author1@email\endcsname{???@???}
\def\journal@type@ru{????}
\def\journal@type@en{????}

\def\issue#1#2#3{
	\def\issue@year{#1}%
	\def\cp@issue@year{,\space#1}%
	\def\issue@number{#2}%
	\def\@section@image@path@prefix{"images/"}
	\ifthenelse{\equal{edu}{#3}}{%
		\def\journal@type{\@langrev{Компьютерные инструменты в образовании}{Computer Tools in Education}}%
		\def\journal@type@ru{{\selectlanguage{russian}Компьютерные инструменты в образовании}}%
		\def\journal@type@en{Computer Tools in Education}%
	}{%
      \ifthenelse{\equal{cam}{#3}}{%
        \def\journal@type{\@langrev{Компьютерная математика}{Computer Assisted Mathematics}}%
        \def\journal@type@ru{{\selectlanguage{russian}Компьютерная математика}}%
        \def\journal@type@en{Computer Assisted Mathematics}%
        \def\@section@image@path@prefix{cam-}%
      }{%
        \def\journal@type{\@langrev{Компьютерные инструменты в школе}{Computer Tools at Schools}}%
      }%
    }%
    \ifthenelse{\equal{cam}{#3}}{%
        \definecolor{rulercolor}{RGB}{32,63,153}
    }{%
        \definecolor{rulercolor}{RGB}{145,56,40}
    }%
}

\newif\if@in@translatedpart
\@in@translatedpartfalse

% Текущий тип статьи: язык определяется флагом \if@englishversion.
% Внутри \translatedpart флаг инвертируется, поэтому проверка одна.
\def\article@type@current{%
	\if@englishversion\article@type@en\else\article@type@ru\fi%
}

\def\article@type@ru{{\selectlanguage{russian}Оригинальное исследование}}
\def\article@type@en{Research article}

\newcommand{\articletr}[2]{%
	\gdef\article@type@ru{#1}%  
	\gdef\article@type@en{#2}%  
}
% Команда для выбора типа статьи
\newcommand{\articletype}[1]{%
	\ifcase#1\relax
	\or % 1
	\gdef\article@type@ru{{\selectlanguage{russian}Оригинальное исследование}}%
	\gdef\article@type@en{Research article}%
	\or % 2
	\gdef\article@type@ru{{\selectlanguage{russian}Обзорная статья}}%
	\gdef\article@type@en{Review article}%
	\or % 3
	\gdef\article@type@ru{{\selectlanguage{russian}Материалы конференции}}%
	\gdef\article@type@en{Conference paper}%
	\or % 4
	\gdef\article@type@ru{{\selectlanguage{russian}Редакционная статья}}%
	\gdef\article@type@en{Editorial article}%
	\or % 5
	\gdef\article@type@ru{{\selectlanguage{russian}Дискуссионная статья}}%
	\gdef\article@type@en{Discussion article}%
	\or % 6
	\gdef\article@type@ru{{\selectlanguage{russian}Краткое сообщение}}%
	\gdef\article@type@en{Short Communication}%
	\fi
}

%\def\article@type{}
%\def\articletype#1{\def\article@type{#1}}
\def\kio@page{\bf \arabic{page}}
\def\doinumber#1{\def\doi@number{#1}}
% Лицензия не подключена
\def\license#1{\def\@license{#1}}
\def\@license{CC~BY~4.0} 
\def\udknumber#1{\def\udk@number{#1}}

\def\bibdoi{\doi}
\def\arxiv#1{\href{http://arxiv.org/abs/#1}{arXiv:#1}}

\def\journalsection#1{%
	\def\@sectionwithimage{true} % Флаг, что раздел С изображением
	\def\journal@section@id{#1}
	\ifthenelse{\equal{informatics}{#1}}{%
		\def\journal@section@name{\@lang{ИНФОРМАТИКА}{COMPUTER SCIENCE}}%
		\setsectionheader{{\selectlanguage{russian}ИНФОРМАТИКА}}{COMPUTER SCIENCE}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{information-systems}{#1}}{%
			\def\journal@section@name{\@lang{ИНФОРМАЦИОННЫЕ СИСТЕМЫ}{INFORMATION SYSTEMS}}%
			\setsectionheader{{\selectlanguage{russian}ИНФОРМАЦИОННЫЕ СИСТЕМЫ}}{INFORMATION SYSTEMS}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{software-engineering}{#1}}{%
			\def\journal@section@name{\@lang{ИНЖЕНЕРИЯ ПРОГРАММНОГО ОБЕСПЕЧЕНИЯ}{SOFTWARE ENGINEERING}}%
			\setsectionheader{{\selectlanguage{russian}ИНЖЕНЕРИЯ ПРОГРАММНОГО ОБЕСПЕЧЕНИЯ}}{SOFTWARE ENGINEERING}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{computer-in-education}{#1}}{%
			\def\journal@section@name{\@lang{КОМПЬЮТЕР В УЧЕБНОМ ПРОЦЕССЕ}{COMPUTER IN EDUCATION}}%
			\setsectionheader{{\selectlanguage{russian}КОМПЬЮТЕР В УЧЕБНОМ ПРОЦЕССЕ}}{COMPUTER IN EDUCATION}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{popular-science-articles}{#1}}{%
			\def\journal@section@name{\@lang{НАУЧНО-ПОПУЛЯРНЫЕ СТАТЬИ}{POPULAR-SCIENCE ARTICLES}}%
			\setsectionheader{{\selectlanguage{russian}НАУЧНО-ПОПУЛЯРНЫЕ СТАТЬИ}}{POPULAR-SCIENCE ARTICLES}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{programming-practice}{#1}}{%
			\def\journal@section@name{\@lang{ПРАКТИКА ПРОГРАММИРОВАНИЯ}{PROGRAMMING PRACTICE}}%
 			\setsectionheader{{\selectlanguage{russian}ПРАКТИКА ПРОГРАММИРОВАНИЯ}}{PROGRAMMING PRACTICE}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{editorial-column}{#1}}{%
			\def\journal@section@name{\@lang{КОЛОНКА РЕДАКТОРА}{EDITORIAL COLUMN}}%
			\setsectionheader{{\selectlanguage{russian}КОЛОНКА РЕДАКТОРА}}{EDITORIAL COLUMN}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{specialists-training-new-teaching-methods}{#1}}{%
			\def\journal@section@name{\@lang{ПОДГОТОВКА СПЕЦИАЛИСТОВ: новые методы обучения}{SPECIALISTS TRAINING: new teaching methods}}%
			\setsectionheader{{\selectlanguage{russian}ПОДГОТОВКА СПЕЦИАЛИСТОВ: новые методы обучения}}{SPECIALISTS TRAINING: new teaching methods}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{specialists-training-training-programs}{#1}}{%
			\def\journal@section@name{\@lang{ПОДГОТОВКА СПЕЦИАЛИСТОВ: программы обучения}{SPECIALISTS TRAINING: training programs}}%
			\setsectionheader{{\selectlanguage{russian}ПОДГОТОВКА СПЕЦИАЛИСТОВ: программы обучения}}{SPECIALISTS TRAINING: training programs}% 
	}{%
		\ifthenelse{\equal{specialists-training-professional-standards}{#1}}{%
			\def\journal@section@name{\@lang{ПОДГОТОВКА СПЕЦИАЛИСТОВ: профессиональные стандарты}{SPECIALISTS TRAINING: professional standards}}%
			\setsectionheader{{\selectlanguage{russian}ПОДГОТОВКА СПЕЦИАЛИСТОВ: профессиональные стандарты}}{SPECIALISTS TRAINING: professional standards}% 
	}{%
		\ifthenelse{\equal{algorithmic-mathematics}{#1}}{%
			\def\journal@section@name{\@lang{АЛГОРИТМИЧЕСКАЯ МАТЕМАТИКА И МАТЕМАТИЧЕСКОЕ МОДЕЛИРОВАНИЕ}{ALGORITHMIC MATHEMATIC AND MATHEMATICAL MODELING}}%
			\setsectionheader{{\selectlanguage{russian}АЛГОРИТМИЧЕСКАЯ МАТЕМАТИКА И МАТЕМАТИЧЕСКОЕ МОДЕЛИРОВАНИЕ}}{ALGORITHMIC MATHEMATIC AND MATHEMATICAL MODELING}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{mathematical-modeling}{#1}}{%
			\def\journal@section@name{\@lang{МАТЕМАТИЧЕСКОЕ МОДЕЛИРОВАНИЕ}{MATHEMATICAL MODELING}}%
			\setsectionheader{{\selectlanguage{russian}МАТЕМАТИЧЕСКОЕ МОДЕЛИРОВАНИЕ}}{MATHEMATICAL MODELING}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{open-problems-for-young-scientists}{#1}}{%
			\def\journal@section@name{\@lang{НЕРЕШЕННЫЕ ЗАДАЧИ ДЛЯ МОЛОДЫХ УЧЕНЫХ}{OPEN PROBLEMS FOR YOUNG SCIENTISTS}}%
			\setsectionheader{{\selectlanguage{russian}НЕРЕШЕННЫЕ ЗАДАЧИ ДЛЯ МОЛОДЫХ УЧЕНЫХ}}{OPEN PROBLEMS FOR YOUNG SCIENTISTS}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{new-section}{#1}}{%
			\def\journal@section@name{\@lang{НОВЫЙ РАЗДЕЛ}{A NEW SECTION}}%
			\setsectionheader{{\selectlanguage{russian}НОВЫЙ РАЗДЕЛ}}{A NEW SECTION}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{artificial-intelligence}{#1}}{%
			\def\journal@section@name{\@lang{ИСКУССТВЕННЫЙ ИНТЕЛЛЕКТ И МАШИННОЕ ОБУЧЕНИЕ}{ARTIFICIAL INTELLIGENCE AND MACHINE LEARNING}}%
			\setsectionheader{{\selectlanguage{russian}ИСКУССТВЕННЫЙ ИНТЕЛЛЕКТ И МАШИННОЕ ОБУЧЕНИЕ}}{ARTIFICIAL INTELLIGENCE AND MACHINE LEARNING}% <-- ДОБАВИТЬ
	}{%
		\ifthenelse{\equal{empty}{#1}}{%
			\def\journal@section@name{}%
			\def\journal@section@img{}%
			\setsectionheader{}{}% <-- ДОБАВИТЬ (пустые значения)
	}{%
		\def\journal@section@name{\@lang{раздел не указан или неизвестен}{section not specified or unknown} #1}%
		\setsectionheader{{\selectlanguage{russian}раздел не указан или неизвестен #1}}{section not specified or unknown #1}% <-- ДОБАВИТЬ
	}%
	}%
	}%
	}%
	}%
	}%
	}%
	}%
	}%
	}%
	}%
	}%
	}%
	}%
	}%
	}%
}
\def\journalsectionnoimage#1{%
	\def\@sectionwithimage{false} % Флаг, что раздел БЕЗ изображения
	\journalsection{#1}%
	\def\no@section@image{}%
}%

\def\print@title{{\LARGE \hv@sf\bfseries\mathversion{bold} \MakeUppercase{\@title} \par}}
\def\print@author{%
    \vskip 1.5em%
    {\hv@sf
      \lineskip .5em%
      \large\upshape
      \begin{varwidth}{\textwidth}\raggedright\authors@all@info\end{varwidth}%
      \par}
  }
\def\print@address{\vskip 0.5em
        \small\hv@sf\upshape\@address\par
        }

% title

\def\pages@span{%
\ifthenelse{\equal{\pageref*{first@page}}{\pageref*{last@page}}}%
        {\pageref*{last@page}}%
        {\pageref*{first@page}--\pageref*{last@page}}%
}

\newcommand\print@doi{\href{https://doi.org/\doi@number}{doi:\doi@number}}
\newcommand\print@doi@full{\url{https://doi.org/\doi@number}}

% Ширина блока с метаданными (тип статьи, выпуск, УДК, URL, DOI).
% Меньшая ширина → блок сдвигается вправо за счёт \hfill между картинкой и блоком.
% Должно хватать на самую длинную строку — обычно DOI (например,
% «doi:10.32603/2071-2340-2026-4-113-129»).
\def\title@full@article@info@width{5.52cm}
\def\title@full@article@info{%
	\begin{minipage}{\title@full@article@info@width}
%		\fbox{% ← Рамка
			\parbox{\linewidth}{% ← Вложенный parbox для точности; текст внутри выровнен влево
				\small\hv@sf
				% ТИП СТАТЬИ ЖИРНЫМ ШРИФТОМ — язык согласно \article@type@current
				\textbf{\article@type@current}\\ [0.6ex]
				№~\issue@number:\space
				\pages@span%
				\@ifundefined{udk@number}{}{\\[0.6ex]\@langrev{УДК}{UDC}:\space\udk@number}%
				\\[0.6ex]\href{http://cte.eltech.ru}{http://cte.eltech.ru}%
				\@ifundefined{doi@number}{}{\\[0.6ex]\print@doi}%
			}
%		}
	\end{minipage}%
}
	\def\title@section@image{%
	  \begin{minipage}{7cm}
	     \@ifundefined{no@section@image}{%
	       \includegraphics[width=7cm]{\@section@image@path@prefix\journal@section@id\@lang{}{-en}.png}%
	     }{%
	%       \hskip 7cm%
	     }
	  \end{minipage}%
	}%

\def\@maketitle{%

	%----------------------------
	\ifthenelse{\isodd{\value{page}}}{%
    % Нечетные страницы: метаданные слева, картинка справа
    \noindent\title@full@article@info\hfill\title@section@image%
}{%
    % Четные страницы: картинка слева, метаданные справа
    \noindent\title@section@image\hfill\title@full@article@info%
}%
	%
	%----------------------------  
	%ruler below title
	%\par\vskip3pt\noindent\textcolor{rulercolor}{\hrulefill}
	{%\raggedright%
		\centering
		\let \footnote \thanks
		\vskip 2cm
		\if@englishversion
			\@ifundefined{@title@en}{}{\let\@title\@title@en\print@title}%
		\else
			\@ifundefined{@title}{}{\print@title}%
		\fi
		\@ifundefined{@author}{}{\print@author}%
		\@ifundefined{@address}{}{\print@address}%
		\if@englishversion\affiliation@footnotes@en\else\affiliation@footnotes\fi
	}%
	\par
	\vskip 1.5em%
}

\renewenvironment{abstract}{%
%   \setcounter{page}{\start@page}\label{first@page}
%    \setcounter{page}{1}\label{first@page}
    \if@twocolumn
      %\section*{Аннотация}%
    \else
      \everypar{\parskip 3pt plus1pt minus2pt
      \parindent=0pt% \hangindent=\@titleindent
      \hangafter=0%
      \leftskip=\@titleindent%
      \rightskip=\@titleindent}
      \noindent\small\hv@sf\upshape\ignorespaces
    \fi
    {\centering\textbf{\kioabstractname}\par}}
    {\if@twocolumn\else\vskip 1.5em plus 0.2em \fi\upshape}

\newcommand\abstract@section[2]{\par\vskip 1ex
        \noindent%
        \raggedright%
        \leftskip=\@titleindent%
        \rightskip=\@titleindent%
        \upshape{\hv@sf\bfseries #1:}#2\space}

\newcommand\keywords{\par\vskip 0.5ex
	\noindent%
	\raggedright%
	\leftskip=\@titleindent%
	\rightskip=\@titleindent%
	\upshape{\hv@sf\bfseries \keywordsname: }\slshape}


\newcommand\acknowledgements[1]{\par\vskip 1ex\noindent\textbf{\acknowledgementsname: }\textit{#1}}

% --- Хелперы для IEEE-стилизации списка авторов ----------------------------

% Перестановка «Lastname I.~I.» → «I.~I. Lastname» (по первому пробелу).
% Перед вызовом полезно сделать \let\affil\@gobble, чтобы убрать аффилиации.
\def\@kio@swap@author#1 #2\@@nil{#2 #1}

% Печать всех авторов в IEEE-стиле:
%   1 author : «I. I. X»
%   2 authors: «I. I. X and J. J. Y»
%   3        : «I. I. X, J. J. Y, and K. K. Z» (Oxford comma)
%   4+       : «I. I. X, J. J. Y, K. K. Z, et al.» (truncate to first 3)
\newcommand{\@kio@ieee@authors}{%
	\count@\z@
	\@authors@iter{@short@en}{\advance\count@\@ne}%
	\edef\@kio@total{\the\count@}%
	\ifnum\@kio@total>4
		\@kio@ieee@authors@truncated
	\else
		\@kio@ieee@authors@full
	\fi
}

% Полный список авторов (n<=4)
\newcommand{\@kio@ieee@authors@full}{%
	\count@\z@
	\@authors@iter{@short@en}{%
		\advance\count@\@ne
		\ifnum\count@>\@ne
			\ifnum\count@=\@kio@total\relax
				\ifnum\@kio@total=\tw@\space and\space\else, and\space\fi
			\else
				, %
			\fi
		\fi
		\edef\@kio@cur{\csname author\author@i @short@en\endcsname}%
		\expandafter\@kio@swap@author\@kio@cur\@@nil
	}%
}

% Усечённый список (n>4): первые три автора через запятую и затем «, et al.».
\newcommand{\@kio@ieee@authors@truncated}{%
	\count@\z@
	\@authors@iter{@short@en}{%
		\advance\count@\@ne
		\ifnum\count@>3\else
			\ifnum\count@>\@ne, \fi
			\edef\@kio@cur{\csname author\author@i @short@en\endcsname}%
			\expandafter\@kio@swap@author\@kio@cur\@@nil
		\fi
	}%
	, et~al.%
}

% «p.» для одной страницы, «pp.» для диапазона — определяется через метки first/last@page.
\newcommand{\@kio@pages@prefix}{%
	\ifthenelse{\equal{\pageref*{first@page}}{\pageref*{last@page}}}{p.}{pp.}%
}

% --- Автогенерируемое цитирование ------------------------------------------
% \autocitation — печатает ярлык «Цитирование/Citation» и автоматически
% собранный пример цитирования.
%   • Русская версия — стиль ГОСТ Р 7.0.100-2018: «Авторы. Название // Журнал.
%     Год. № Номер. С. Страницы. doi:…».
%   • Английская версия — IEEE-стиль: «I. I. Author1, …, and I. I. AuthorN,
%     “Title,” Journal, no. N, pp. P–Q, Year, doi:…».
% Используются полные названия (\@title / \@title@en).
\newcommand\autocitation{%
  \par\vskip 1ex\noindent\textbf{\citationname: }%
  \begingroup
    \let\affil\@gobble % в цитировании не нужны индексы аффилиаций
    \@langrev{%
      % Русский / ГОСТ
      \authors@short@truncated\space\@title\space//
      \space\journal@type. \issue@year. № \issue@number. С.~\pages@span.%
      \@ifundefined{doi@number}{}{\space\print@doi.}%
    }{%
      % English / IEEE
      \@kio@ieee@authors, ``\@title@en,''\space
      \journal@type@en, no.~\issue@number, \@kio@pages@prefix~\pages@span, \issue@year%
      \@ifundefined{doi@number}{}{, \print@doi}.%
    }%
  \endgroup
}

% --- Ручное цитирование ---
% \manualcitation{<текст>} — печатает ярлык «Цитирование/Citation» и далее
% переданный пользователем текст. Пример:
%   \manualcitation{Andreev A.~A., Borisov B.~B. Article title. Journal, 2026.}
\newcommand{\manualcitation}[1]{%
  \par\vskip 1ex\noindent\textbf{\citationname: }#1%
}

\newcommand\pacs{\par\vskip 1ex
        \noindent\raggedright\upshape{\hv@sf\bfseries PACS:}\slshape\space}

% =========================================================================
% Generic author API: \author{N}[short]{full}, \authoren{N}[short]{full},
% \authorinfo{N}{...}, \authorinfoen{N}{...},
% \authoremail{N}{...}, \authoremailEnvelope{N}{...}, \authororcid{N}{...}.
% N is an Arabic numeral; it is used directly as the key inside \csname...\endcsname.
% =========================================================================

% \author{N}[short]{full}
\def\author#1{\@dblarg{\make@author{#1}}}
\long\def\make@author#1[#2]#3{%
	\expandafter\gdef\csname author#1@short\endcsname{#2}%
	\expandafter\gdef\csname author#1@full\endcsname{#3}%
	% English defaults (overridden by \authoren{N}[...]{...} if used)
	\expandafter\gdef\csname author#1@short@en\endcsname{#2}%
	\expandafter\gdef\csname author#1@full@en\endcsname{#3}%
}

% \authoren{N}[short]{full}
\def\authoren#1{\@dblarg{\make@authoren{#1}}}
\long\def\make@authoren#1[#2]#3{%
	\expandafter\gdef\csname author#1@short@en\endcsname{#2}%
	\expandafter\gdef\csname author#1@full@en\endcsname{#3}%
}

% \authorinfo{N}{...} / \authorinfoen{N}{...}
\newcommand{\authorinfo}[2]{%
	\expandafter\def\csname author#1@info\endcsname{#2}%
	\expandafter\def\csname author#1@info@en\endcsname{#2}%
}
\newcommand{\authorinfoen}[2]{%
	\expandafter\def\csname author#1@info@en\endcsname{#2}%
}

% \authoremail{N}{...} / \authoremailEnvelope{N}{...}
\newcommand{\authoremail}[2]{%
	\expandafter\def\csname author#1@email\endcsname{#2}%
}
\newcommand{\authoremailEnvelope}[2]{%
	\authoremail{#1}{#2}%
	\expandafter\def\csname author#1@email@recepient\endcsname{}%
}

% \authororcid{N}{...}
\newcommand{\authororcid}[2]{%
	\expandafter\def\csname author#1@orcid\endcsname{#2}%
}

\def\title{\@dblarg{\make@title}}
\long\def\make@title[#1]#2{
	\gdef\fancy@title{#1}
	\gdef\fancy@header@title{#1}
	\gdef\@title{#2}
	\gdef\@title@en{#1} % английская версия
}

% Команда для английского заголовка
\def\titleen{\@dblarg{\make@titleen}}
\long\def\make@titleen[#1]#2{
	\gdef\fancy@title@en{#1}
	\gdef\fancy@header@title@en{#1}
	\gdef\@title@en{#2}
}

\def\print@author@en{%
	\vskip 1.5em%
	{\hv@sf
		\lineskip .5em%
		\large\upshape
		\def\authorinfo##1{
			\setstretch{0.9}
			\csname author##1@short@en\endcsname%
			\ifcsname author##1@email\endcsname%
			\hspace{0.5em}%
			\ifcsname author##1@email@recepient\endcsname\@Letter\fi%
			\hspace{0.5em}\href{mailto:\csname author##1@email\endcsname}{\csname author##1@email\endcsname}%
			\fi
			\ifcsname author##1@orcid\endcsname%
			, \href{https://\csname author##1@orcid\endcsname}{\csname author##1@orcid\endcsname}%
			\fi
		}
		\@authors@iter{@short@en}{\authorinfo{\author@i}\par}%
		\par}
}

% Команды колонтитулов
\def\@russianarticleheader{}
\def\@englisharticleheader{}
\def\@russianauthorsheader{}
\def\@englishauthorsheader{}
\def\@russiansectionheader{}
\def\@englishsectionheader{}
\def\@sectionwithimage{false}
\newif\iffirstpage
\firstpagetrue


% Ключевые слова — печатают свой блок прямо на месте вызова.
% Текст аннотации и дополнительной информации пользователь записывает напрямую
% внутри \begin{abstract} и \additionalinfo{...}.
% Пример цитирования формируется автоматически командой \autocitation.
\newcommand{\keywordsru}[1]{%
	\par\vskip 0.5ex\noindent\textbf{Ключевые слова: }\textit{#1}%
}
\newcommand{\keywordsen}[1]{%
	\par\vskip 0.5ex\noindent\textbf{Keywords: }\textit{#1}%
}

% Благодарности / Acknowledgments
\newcommand{\acknowledgmentsru}[1]{%
	\par\vskip 1ex\noindent\textbf{Благодарности: }\textit{#1}%
}
\newcommand{\acknowledgmentsen}[1]{%
	\par\vskip 1ex\noindent\textbf{Acknowledgments: }\textit{#1}%
}

% Вклад авторов / Authors' Contributions
\newcommand{\authorscontributionsru}[1]{%
	\par\vskip 1ex\noindent\textbf{Вклад авторов: }\textit{#1}%
}
\newcommand{\authorscontributionsen}[1]{%
	\par\vskip 1ex\noindent\textbf{Authors' Contributions: }\textit{#1}%
}

% Финансирование / Funding
\newcommand{\fundingru}[1]{%
	\par\vskip 1ex\noindent\textbf{Финансирование: }\textit{#1}%
}
\newcommand{\fundingen}[1]{%
	\par\vskip 1ex\noindent\textbf{Funding: }\textit{#1}%
}

% Конфликт интересов / Conflict of Interest
\newcommand{\conflictofinterestru}[1]{%
	\par\vskip 1ex\noindent\textbf{Конфликт интересов: }\textit{#1}%
}
\newcommand{\conflictofinteresten}[1]{%
	\par\vskip 1ex\noindent\textbf{Conflict of Interest: }\textit{#1}%
}

\def\address#1{\gdef\@address{#1}}
\def\addresses#1{\gdef\@address{%
    \renewcommand{\labelenumi}{$^{\textsf{\footnotesize\arabic{enumi}}}$}
    \setlength{\leftmargini}{0mm}
    \setlength{\topsep}{0mm}
    \setlength{\partopsep}{0mm}
    \setlength{\parskip}{0mm}
    \begin{enumerate}
    \setlength{\itemsep}{0mm}
    \setlength{\itemindent}{0em}
    \setlength{\labelsep}{2pt}
    #1
    \end{enumerate}}}

%        Настройка колонтитулов       
\newcommand{\setarticleheader}[2]{%
	\def\@russianarticleheader{{\selectlanguage{russian}#1}}%
	\def\@englisharticleheader{#2}%
}

\newcommand{\setauthorsheader}[2]{%
	\def\@russianauthorsheader{{\selectlanguage{russian}#1}}%
	\def\@englishauthorsheader{#2}%
}

\newcommand{\setsectionheader}[2]{%
	\def\@russiansectionheader{{\selectlanguage{russian}#1}}%
	\def\@englishsectionheader{#2}%
}

\DeclareRobustCommand\@refad{\@@refadx}
\def\@@refadx#1{%
  \let\@@refada\@empty
  \@@refad{\@for\@@refadb:=#1\do
    {\@@refada\def\@@refada{,\penalty\@m}%
     \edef\@@refadb{\expandafter\@firstofone\@@refadb\@empty}%
     \@ifundefined{r@\@@refadb}{\mbox{\reset@font\bfseries ?}%
       \G@refundefinedtrue
       \@latex@warning
         {Address reference `\@@refadb' undefined}}%
       {\hbox{\ref{\@@refadb}}}}}}
\def\@@refad#1{{#1}}

%%  Floats  %%

%\bibsep=0pt
%\renewcommand{\bibnumfmt}[1]{#1.}
\@ifundefined{bibfont}{\newcommand{\bibfont}{\small}}{\renewcommand{\bibfont}{\small}}

%%  Английская часть  %%

\newcommand\maketranslatedtitle{
	\begingroup
	\global\@botnum\z@   % Не разрешаем рисунки внизу страницы.
	% Внутри \translatedpart \if@englishversion уже отражает язык перевода.
	\if@englishversion\let\@title\@title@en\fi
	\@makerutitle
	\@thanks
	\endgroup
	\global\let\thanks\relax
	\global\let\makerutitle\relax
	\global\let\@makerutitle\relax
	\global\let\@thanks\@empty
	% \@title и \@title@en НЕ очищаем — они нужны позже для \autocitation.
	\global\let\@author\@empty
	\global\let\@date\@empty
	\global\let\title\relax
	\global\let\author\relax
	\global\let\date\relax
	\global\let\and\relax
}
\def\print@rutitle{{\Large \hv@sf\bfseries\mathversion{bold}{\@title} \par}}

\def\@makerutitle{%
	\par
	\vskip 10pt
	\noindent\null
	\ifthenelse{\isodd{\value{page}}}{%
		% Нечетные страницы
		\noindent\hfill%
		\begin{minipage}[t]{5.5cm}
			\raggedleft
			\title@full@article@info
		\end{minipage}
	}{%
		% Четные страницы
		\noindent\title@full@article@info\hfill%
	}
	\vskip 1.5em
	\noindent\null
	\raggedright%
	\centering
	\let \footnote \thanks
	
	\if@englishversion
		\@ifundefined{@title@en}{}{\def\@title{\@title@en}}%
	\fi
	\@ifundefined{@title}{}{\print@rutitle}%
	\global\let\affil\@affil%

	% Информация об авторах: \print@author уже выбирает язык по \if@englishversion.
	\print@author

	\@ifundefined{@address}{}{\print@address}%
	% Аффилиации соответствуют языку перевода.
	\if@englishversion\affiliation@footnotes@en\else\affiliation@footnotes\fi
	\global\let\affil\relax@with@arg%
	\par
	\vskip 1.5em%
}

\newenvironment{translatedpart}{%
	\def\@has@translated@part{}
	\@in@translatedparttrue
	\@flip@englishversion % язык переключается на противоположный
	\lefthyphenmin=2 \righthyphenmin=2 % disallow x- or -x breaks; -xx OK
	\lccode`\'=`\'
	\def\@reverse@lang{}
	
%%     ПРОВЕРКА МЕСТА    

	% Сбрасываем штрафы для проверки места
	\widowpenalty=0
	\clubpenalty=0
	
	% Проверяем, есть ли хотя бы 50% страницы свободно
	\@tempdima=\pagegoal \advance\@tempdima-\pagetotal
	\@tempdimb=0.5\pagegoal  % 50% от высоты страницы
	
	\ifdim\@tempdima>\@tempdimb
	% Есть достаточно места - рисуем линию
	\vspace{12pt}
	{\color{rulercolor}%
		\hrule width\headwidth height\headrulewidth
		\vspace{1pt}
		\hrule width\headwidth height\headrulewidth}
	\vspace{12pt}
	\else
	% Недостаточно места - новая страница
	\newpage
	\fi
	\@firstpagefalse
}{
	% В КОНЦЕ переведённой части выводим расширенную информацию об авторах
	% на языке перевода (\if@englishversion уже инвертирован для translatedpart).
	\@ifundefined{need@authors@info}{}{
		\vspace*{1cm}
		\par
		\addvspace{6pt}
		\widowpenalty=0
		\clubpenalty=0

		\printauthorsinfo
	}
	\@flip@englishversion % восстанавливаем исходный язык
}

\newcommand\additionalinfo[1]{
\begin{center}
{\noindent\small\hv@sf\upshape\ignorespaces #1}
\end{center}
}

%%  General  %%

%\voffset -1in
%\hoffset -1in
\textwidth 150mm
%\textheight 227mm
\textheight 646pt    % = 227.0430331mm
\topmargin 30mm
\headheight 15pt
\headsep 10mm
%\footskip 25mm   % Добавили отступ для нижнего колонтитула
\addtolength{\topmargin}{-\headheight}
\addtolength{\topmargin}{-\headsep}
\addtolength{\topmargin}{-1in}
\oddsidemargin 35mm
\setlength{\evensidemargin}{210mm}
\addtolength{\evensidemargin}{-\textwidth}
\addtolength{\evensidemargin}{-\oddsidemargin}
\addtolength{\oddsidemargin}{-1in}
\addtolength{\evensidemargin}{-1in}
\baselineskip 15pt
\newlength{\@titlewidth}
\newlength{\@titleindent}
\setlength{\@titlewidth}{\textwidth}
\setlength{\@titleindent}{15mm}
\addtolength{\@titlewidth}{-\@titleindent}
\newlength{\@captionwidth}
%\setlength{\@captionwidth}{\hsize}
%\addtolength{\@captionwidth}{-2\parindent}
%P%\renewcommand{\encodingdefault}{T1}
%\renewcommand{\sfdefault}{phv}
\renewcommand{\sfdefault}{\lat@sf}
\frenchspacing
\let\@afterindentfalse\@afterindenttrue

\renewcommand\footnoterule{%
  \vskip 8\p@ \@plus\z@ \@minus 5\p@
  \color{rulercolor}\hrule height 0.4pt \@width\textwidth
  \vskip 12\p@ \@plus\z@ \@minus 3\p@}
\setlength{\skip\footins}{12pt plus 2pt minus 6pt}
\setlength{\footnotesep}{5pt}

%%  Headings  %%

%\def\sf@phv{\fontencoding{T1}\fontfamily{phv}\selectfont\upshape}
%P1%\def\sf@phv{\fontencoding{T1}\fontfamily{\lat@sf}\selectfont\upshape}
\def\sf@phv{\fontfamily{\lat@sf}\selectfont\upshape}
\newcounter{isspage}
\def\issue@page@odd{}
\def\issue@page@even{}
\def\issuepage#1{%
      \oddsidemargin 20mm%
      \setlength{\evensidemargin}{210mm}%
      \addtolength{\evensidemargin}{-\textwidth}%
      \addtolength{\evensidemargin}{-\oddsidemargin}%
      \addtolength{\oddsidemargin}{-1in}
      \addtolength{\evensidemargin}{-1in}
                 \setcounter{isspage}{#1}%
                 \addtocounter{isspage}{-1}%
                 \def\issue@page@odd{%
                     \stepcounter{isspage}%
                     {\unitlength1mm%
                     \begin{picture}(0,0)%
%                     \put(30,10){\makebox(0,0)[l]{\vrule height 20pt}}%
                     \put(30.5,10){\makebox(0,0)[l]{\rotatebox{90}{\textsf{\theisspage}}}}%
                     \end{picture}}%
                     }%
                 \def\issue@page@even{%
                     \stepcounter{isspage}%
                     {\unitlength1mm%
                     \begin{picture}(0,0)%
%                     \put(-30,10){\makebox(0,0)[l]{\vrule height 20pt}}%
                     \put(-30,10){\makebox(0,0)[r]{\rotatebox{90}{\textsf{\theisspage}}}}%
                     \end{picture}}%
                     }%
}


\renewcommand{\headrule}{\fancyplain{}{{\color{rulercolor}%
			\hrule width\headwidth height\headrulewidth \vskip-\headrulewidth}}}

\renewcommand{\footrule}{{\color{rulercolor}%
		\vskip-\footruleskip\vskip-\footrulewidth% 
		\hrule width\headwidth height\footrulewidth\vskip\footruleskip}}

\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}
\renewcommand{\plainheadrulewidth}{0pt}
\renewcommand{\plainfootrulewidth}{0.4pt}

%        Стили страниц       

% КОЛОНТИТУЛЫ ВСЕХ СТРАНИЦ КРОМЕ 1-ОЙ

\fancypagestyle{mainstyle}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}

	% Верхние колонтитулы. Используем \ifenglishpaper (постоянный по всему документу),
	% чтобы внутри \translatedpart колонтитулы НЕ переключались на другой язык.
	\fancyhead[RO]{%
		\normalsize\sf@phv\textcolor{rulercolor}{%
			\ifenglishpaper\@englisharticleheader\else\@russianarticleheader\fi
		}%
	}

	\fancyhead[LE]{%
		\normalsize\sf@phv\textcolor{rulercolor}{%
			\ifenglishpaper\@englishauthorsheader\else\@russianauthorsheader\fi
		}%
	}

	% НИЖНИЕ КОЛОНТИТУЛЫ С НОМЕРАМИ СТРАНИЦ ВНУТРИ
	\fancyfoot[RO]{%
		\normalsize\sf@phv\textcolor{rulercolor}{%
			\ifenglishpaper
				\ \MakeTextUppercase{\journal@type@en}\ \issue@year.\ no.\ \issue@number.\ pp.\ \pages@span
			\else
				\ \MakeTextUppercase{\journal@type@ru}\ \issue@year.\ {\selectlanguage{russian}№\ \issue@number.\ С.\ \pages@span}
			\fi
		}%
		\hfill
		\normalsize\sf@phv\textcolor{black}{\kio@page}
	}

	\fancyfoot[LE]{%
		\normalsize\sf@phv\textcolor{black}{\kio@page}
		\hfill
		\normalsize\sf@phv\textcolor{rulercolor}{%
			\ifenglishpaper\@englishsectionheader\else\@russiansectionheader\fi
		}%
	}
}

% КОЛОНТИТУЛЫ ПЕРВОЙ СТРАНИЦЫ 
\fancypagestyle{firstpagestyle}{%
	\fancyhf{}

	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0.4pt}
	
	% Убираем стандартные отступы fancyhdr
	\fancyheadoffset{0pt}
	\fancyfootoffset{0pt}
	
	%     ПРАВАЯ СТРАНИЦА (нечетная)
	\fancyfoot[RO]{%
		\footnotesize\sf@phv%
		\hspace*{0pt}% Компенсируем левый отступ
		% Журнал к левому краю
		\begin{minipage}[t]{0.6\textwidth}
			\raggedright\sloppy
			\hyphenpenalty=10000
			\exhyphenpenalty=10000
			\emergencystretch=0em
			\textcolor{rulercolor}{%
				\ifenglishpaper
					\noindent\copyright\
					\MakeTextUppercase{\journal@type@en}, \issue@year%
				\else
					\noindent\copyright\ \MakeTextUppercase{\journal@type@ru}, \issue@year%
				\fi
			}
		\end{minipage}%
		\hfill%
		% Иконка CC BY по центру (файл лежит в каталоге images/)
		\raisebox{-3.0ex}{%
			\IfFileExists{images/cc-by.png}{%
				\includegraphics[height=4.5ex]{images/cc-by.png}%
			}{}%
		}%
%		\hfill%
		% Номер страницы к правому краю
%		\hspace*{0pt plus 1fill}
		\hspace{1em}
		\normalsize\textcolor{black}{\kio@page}%
	}

	%     ЛЕВАЯ СТРАНИЦА (четная)
	\fancyfoot[LE]{%
		\footnotesize\sf@phv%
		\hspace*{0pt}% Компенсируем левый отступ
		% Номер страницы к левому краю
		\normalsize\textcolor{black}{\kio@page}%
		\hspace*{20pt plus 1fill}%
		% Иконка CC BY точно по центру (файл лежит в каталоге images/)
		\raisebox{-3.0ex}{%
			\IfFileExists{images/cc-by.png}{%
				\includegraphics[height=4.5ex]{images/cc-by.png}%
			}{}%
		}%
		\hfill%
		% Журнал к правому краю
		\begin{minipage}[t]{0.75\textwidth}
			\raggedleft\sloppy
			\hyphenpenalty=10000
			\exhyphenpenalty=10000
			\emergencystretch=2em
			\textcolor{rulercolor}{%
				\ifenglishpaper
					\noindent\copyright\ \MakeTextUppercase{\journal@type@en}, \issue@year%
				\else
					\noindent\noindent\copyright\ \MakeTextUppercase{\journal@type@ru}, \issue@year%
				\fi
			}
		\end{minipage}%
		\hspace*{0pt}% Компенсируем правый отступ
	}
}

\pagestyle{mainstyle}

\lefthyphenmin=2
\righthyphenmin=3

\newcommand\printauthorsinfo{
	\@ifundefined{need@authors@info}{}{
		\par
		\addvspace{0pt}  % Добавляем отступ сверху
		\widowpenalty=300  % Запрещаем висячие строки
		\clubpenalty=300
		\noindent
		\begin{minipage}[b]{\textwidth}%
%			\bfseries
			\sf@phv
			
			\def\authorlonginfo##1{
				\setstretch{0.9}
				\noindent
				\csname author##1@full\endcsname,
				\ifcsname author##1@info\endcsname \csname author##1@info\endcsname\fi,
				\ifcsname author##1@email\endcsname\ifcsname author##1@email@recepient\endcsname\@Letter~\fi\href{mailto:\csname author##1@email\endcsname}{\csname author##1@email\endcsname}\fi
			}
			
			\def\allauthorslonginfo{%
				\def\authorlonginfo####1{%
					\setstretch{0.9}%
					\noindent%
					\if@englishversion%
					\csname author####1@full@en\endcsname%
					\ifcsname author####1@info@en\endcsname, \csname author####1@info@en\endcsname\fi%
					\else%
					\csname author####1@full\endcsname%
					\ifcsname author####1@info\endcsname, \csname author####1@info\endcsname\fi%
					\fi%
					\ifcsname author####1@email\endcsname%
					\ifcsname author####1@email@recepient\endcsname%
					, \@Letter\ \href{mailto:\csname author####1@email\endcsname}{\csname author####1@email\endcsname}%
					\else%
					, \href{mailto:\csname author####1@email\endcsname}{\csname author####1@email\endcsname}%
					\fi%
					\fi%
				}%
				\let\@author@sep\@empty
				\@authors@iter{@short}{%
					\@author@sep
					\authorlonginfo{\author@i}\par
					\def\@author@sep{\vskip 2mm}%
				}%
			}
			
			\allauthorslonginfo
			
		\end{minipage}
	}
}

% Старая команда
\let\print@authors@info\printauthorsinfo

\AtEndDocument{%
	\lastpage%
}
\ifpdftex
	\RequirePackage[T2A]{fontenc} % package 'fourier' sets T1 encoding
\fi

\ifpdftex
    \makeatletter
        \AtBeginDocument{%
            \gdef\f@encoding{T2A}%
        }
    \makeatother
\fi
\ifxetex
    \usepackage{fontspec}
\fi

\newcites{eng}{References}


\AtBeginDocument{%
	\DeclareRobustCommand{\mylinkurl}{%
		\begingroup
		\catcode`\_=12\relax \catcode`\~=12\relax \catcode`\#=12\relax
		\catcode`\%=12\relax \catcode`\&=12\relax \catcode`\$=12\relax
		\catcode`\^=12\relax
		\mylinkurl@scan}%
	\def\mylinkurl@scan#1{\href{https://doi.org/#1}{#1}\endgroup}%
}

\usepackage{letltxmacro}

\LetLtxMacro{\originalcite}{\cite}

%\let\originalcite\cite

\makeatletter
\renewcommand{\cite}[2][]{%
  \begingroup
    \def\@cite@post{#1}%
    \ifx\@cite@post\@empty
      \originalcite{#2}%
    \else
      \originalcite[\@cite@post]{#2}%
    \fi
    \if@englishversion
    \else
      \@for\@tmp:=#2\do{%
        \edef\@tmp@en{EN-\@tmp}%
        \expandafter\nociteeng\expandafter{\@tmp@en}%
      }%
    \fi
  \endgroup
}
\makeatother

\makeatletter
\renewcommand\@biblabel[1]{#1.}
\makeatother


%\pagestyle{mainstyle}
\endinput
