\name{NEWS}
\title{News for Package 'rk.FactorAnalysis'}
\encoding{UTF-8}
\section{Changes in rk.FactorAnalysis version 0.01-16 (2022-05-03)}{
  \subsection{fixed}{
    \itemize{
      \item screenshot URL and removed flattr-link in README.md
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-15 (2017-02-25)}{
  \subsection{fixed}{
    \itemize{
      \item fixed a missing comma in the printout code
      \item fixed factor loadings highlighting (now also respects negative loadings)
    }
  }
  \subsection{added}{
    \itemize{
      \item new dialog to calculate measure of sampling adequacy (MSA,
        Kaiser-Meyer-Olkin)
    }
  }
  \subsection{changed}{
    \itemize{
      \item updated \code{rk.header()} code to newer style
      \item the single script file was split into one file for each component
      \item adjusted the generator script to implement the new preview approach,
        using \code{"printout"} and dropping \code{"doPrintout"}
      \item updated german tralsation
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-14 (2015-12-18)}{
  \subsection{added}{
    \itemize{
      \item plugin is now translatable (see inst/rkward/po/)
      \item german translation
    }
  }
  \subsection{changed}{
    \itemize{
      \item updated the generator script
      \item rebuilt with rkwarddev 0.08-1
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-13 (2015-03-14)}{
  \subsection{fixed}{
    \itemize{
      \item replaced the outdated links to sourceforge with our new KDE URL
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-12 (2015-03-13)}{
  \subsection{changed}{
    \itemize{
      \item rebuilt using rkwarddev 0.07-1
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-11 (2013-04-04)}{
  \subsection{added}{
    \itemize{
      \item debianized the plugin
    }
  }
  \subsection{fixed}{
    \itemize{
      \item removed erroneous pluginmap inclusions from XML files
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-10 (2013-02-24)}{
  \subsection{changed}{
    \itemize{
      \item updated rkwarddev generator script (compatibility with 0.06-2) and
        regenerated plugin code
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-9 (2012-10-08)}{
  \subsection{fixed}{
    \itemize{
      \item bug in testing for rotation method led to errors when trying to compute
        variance explained when orthogonal rotation was used with PCA. the result
        was that no real output was generated, only an error message
    }
  }
  \subsection{added}{
    \itemize{
      \item added VSS/MAP dialog
    }
  }
  \subsection{changed}{
    \itemize{
      \item moved parallel analysis and scree plot from \code{"plots"} to \code{"analysis"}
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-8 (2012-09-29)}{
  \subsection{fixed}{
    \itemize{
      \item added generic pre/post plot options
      \item ChangeLog now shows the correct package name...
      \item a typo (thx birk ;-))
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-7 (2012-08-26)}{
  \subsection{fixed}{
    \itemize{
      \item scree plot dialog referenced the wrong varselector
    }
  }
  \subsection{added}{
    \itemize{
      \item dialog for Horn's parallel analysis plots
    }
  }
}
\section{Changes in rk.FactorAnalysis version 0.01-6 (2012-04-07)}{
  \subsection{changes}{
    \itemize{
      \item added a ChangeLog file
      \item rebuild package for R 2.15
    }
  }
}
