% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tinter.R
\name{tinter}
\alias{tinter}
\title{Generate shades, tints or both from a colour.}
\usage{
tinter(x, steps = 5, crop = 1, direction = "both")
}
\arguments{
\item{x}{A string of a colour in any format accepted by grDevices::col2rgb().}

\item{steps}{An integer indicating how many shades/tints to generate (excluding x).}

\item{crop}{An integer indicating how many extreme colours to remove (e.g. crop = 1 eliminates 'black' and 'white').}

\item{direction}{A string indicating whether to include 'tints', 'shades' or 'both'.}
}
\value{
A vector of colours.
}
\description{
Generate shades, tints or both from a colour.
}
