## Copyright (C) 2006, 2007 Arno Onken <asnelt@asnelt.org>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {[@var{transprobest}, @var{outprobest}] =} hmmestimate (@var{sequence}, @var{states})
## @deftypefnx {Function File} {} hmmestimate (@dots{}, 'statenames', @var{statenames})
## @deftypefnx {Function File} {} hmmestimate (@dots{}, 'symbols', @var{symbols})
## @deftypefnx {Function File} {} hmmestimate (@dots{}, 'pseudotransitions', @var{pseudotransitions})
## @deftypefnx {Function File} {} hmmestimate (@dots{}, 'pseudoemissions', @var{pseudoemissions})
## Estimate the matrix of transition probabilities and the matrix of output
## probabilities of a given sequence of outputs and states generated by a
## hidden Markov model. The model assumes that the generation starts in
## state @code{1} at step @code{0} but does not include step @code{0} in the
## generated states and sequence.
##
## @subheading Arguments
##
## @itemize @bullet
## @item
## @var{sequence} is a vector of a sequence of given outputs. The outputs
## must be integers ranging from @code{1} to the number of outputs of the
## hidden Markov model.
##
## @item
## @var{states} is a vector of the same length as @var{sequence} of given
## states. The states must be integers ranging from @code{1} to the number
## of states of the hidden Markov model.
## @end itemize
##
## @subheading Return values
##
## @itemize @bullet
## @item
## @var{transprobest} is the matrix of the estimated transition
## probabilities of the states. @code{transprobest(i, j)} is the estimated
## probability of a transition to state @code{j} given state @code{i}.
##
## @item
## @var{outprobest} is the matrix of the estimated output probabilities.
## @code{outprobest(i, j)} is the estimated probability of generating
## output @code{j} given state @code{i}.
## @end itemize
##
## If @code{'symbols'} is specified, then @var{sequence} is expected to be a
## sequence of the elements of @var{symbols} instead of integers.
## @var{symbols} can be a cell array.
##
## If @code{'statenames'} is specified, then @var{states} is expected to be
## a sequence of the elements of @var{statenames} instead of integers.
## @var{statenames} can be a cell array.
##
## If @code{'pseudotransitions'} is specified then the integer matrix
## @var{pseudotransitions} is used as an initial number of counted
## transitions. @code{pseudotransitions(i, j)} is the initial number of
## counted transitions from state @code{i} to state @code{j}.
## @var{transprobest} will have the same size as @var{pseudotransitions}.
## Use this if you have transitions that are very unlikely to occur.
##
## If @code{'pseudoemissions'} is specified then the integer matrix
## @var{pseudoemissions} is used as an initial number of counted outputs.
## @code{pseudoemissions(i, j)} is the initial number of counted outputs
## @code{j} given state @code{i}. If @code{'pseudoemissions'} is also
## specified then the number of rows of @var{pseudoemissions} must be the
## same as the number of rows of @var{pseudotransitions}. @var{outprobest}
## will have the same size as @var{pseudoemissions}. Use this if you have
## outputs or states that are very unlikely to occur.
##
## @subheading Examples
##
## @example
## @group
## transprob = [0.8, 0.2; 0.4, 0.6];
## outprob = [0.2, 0.4, 0.4; 0.7, 0.2, 0.1];
## [sequence, states] = hmmgenerate (25, transprob, outprob);
## [transprobest, outprobest] = hmmestimate (sequence, states)
## @end group
##
## @group
## symbols = @{'A', 'B', 'C'@};
## statenames = @{'One', 'Two'@};
## [sequence, states] = hmmgenerate (25, transprob, outprob,
##                      'symbols', symbols, 'statenames', statenames);
## [transprobest, outprobest] = hmmestimate (sequence, states,
##                              'symbols', symbols,
##                              'statenames', statenames)
## @end group
##
## @group
## pseudotransitions = [8, 2; 4, 6];
## pseudoemissions = [2, 4, 4; 7, 2, 1];
## [sequence, states] = hmmgenerate (25, transprob, outprob);
## [transprobest, outprobest] = hmmestimate (sequence, states, 'pseudotransitions', pseudotransitions, 'pseudoemissions', pseudoemissions)
## @end group
## @end example
##
## @subheading References
##
## @enumerate
## @item
## Wendy L. Martinez and Angel R. Martinez. @cite{Computational Statistics
## Handbook with MATLAB}. Appendix E, pages 547-557, Chapman & Hall/CRC,
## 2001.
##
## @item
## Lawrence R. Rabiner. A Tutorial on Hidden Markov Models and Selected
## Applications in Speech Recognition. @cite{Proceedings of the IEEE},
## 77(2), pages 257-286, February 1989.
## @end enumerate
## @end deftypefn

## Author: Arno Onken <asnelt@asnelt.org>
## Description: Estimation of a hidden Markov model for a given sequence

function [transprobest, outprobest] = hmmestimate (sequence, states, varargin)

  # Check arguments
  if (nargin < 2 || mod (length (varargin), 2) != 0)
    print_usage ();
  endif

  len = length (sequence);
  if (length (states) != len)
    error ("hmmestimate: sequence and states must have equal length");
  endif

  # Flag for symbols
  usesym = false;
  # Flag for statenames
  usesn = false;

  # Variables for return values
  transprobest = [];
  outprobest = [];

  # Process varargin
  for i = 1:2:length (varargin)
    # There must be an identifier: 'symbols', 'statenames',
    # 'pseudotransitions' or 'pseudoemissions'
    if (! ischar (varargin{i}))
      print_usage ();
    endif
    # Upper case is also fine
    lowerarg = lower (varargin{i});
    if (strcmp (lowerarg, 'symbols'))
      usesym = true;
      # Use the following argument as symbols
      symbols = varargin{i + 1};
    # The same for statenames
    elseif (strcmp (lowerarg, 'statenames'))
      usesn = true;
      # Use the following argument as statenames
      statenames = varargin{i + 1};
    elseif (strcmp (lowerarg, 'pseudotransitions'))
      # Use the following argument as an initial count for transitions
      transprobest = varargin{i + 1};
      if (! ismatrix (transprobest))
        error ("hmmestimate: pseudotransitions must be a non-empty numeric matrix");
      endif
      if (rows (transprobest) != columns (transprobest))
        error ("hmmestimate: pseudotransitions must be a square matrix");
      endif
    elseif (strcmp (lowerarg, 'pseudoemissions'))
      # Use the following argument as an initial count for outputs
      outprobest = varargin{i + 1};
      if (! ismatrix (outprobest))
        error ("hmmestimate: pseudoemissions must be a non-empty numeric matrix");
      endif
    else
      error ("hmmestimate: expected 'symbols', 'statenames', 'pseudotransitions' or 'pseudoemissions' but found '%s'", varargin{i});
    endif
  endfor

  # Transform sequence from symbols to integers if necessary
  if (usesym)
    # sequenceint is used to build the transformed sequence
    sequenceint = zeros (1, len);
    for i = 1:length (symbols)
      # Search for symbols(i) in the sequence, isequal will have 1 at
      # corresponding indices; i is the right integer for that symbol
      isequal = ismember (sequence, symbols(i));
      # We do not want to change sequenceint if the symbol appears a second
      # time in symbols
      if (any ((sequenceint == 0) & (isequal == 1)))
        isequal *= i;
        sequenceint += isequal;
      endif
    endfor
    if (! all (sequenceint))
      index = max ((sequenceint == 0) .* (1:len));
      error (["hmmestimate: sequence(" int2str (index) ") not in symbols"]);
    endif
    sequence = sequenceint;
  else
    if (! isvector (sequence))
      error ("hmmestimate: sequence must be a non-empty vector");
    endif
    if (! all (ismember (sequence, 1:max (sequence))))
      index = max ((ismember (sequence, 1:max (sequence)) == 0) .* (1:len));
      error (["hmmestimate: sequence(" int2str (index) ") not feasible"]);
    endif
  endif

  # Transform states from statenames to integers if necessary
  if (usesn)
    # statesint is used to build the transformed states
    statesint = zeros (1, len);
    for i = 1:length (statenames)
      # Search for statenames(i) in states, isequal will have 1 at
      # corresponding indices; i is the right integer for that statename
      isequal = ismember (states, statenames(i));
      # We do not want to change statesint if the statename appears a second
      # time in statenames
      if (any ((statesint == 0) & (isequal == 1)))
        isequal *= i;
        statesint += isequal;
      endif
    endfor
    if (! all (statesint))
      index = max ((statesint == 0) .* (1:len));
      error (["hmmestimate: states(" int2str (index) ") not in statenames"]);
    endif
    states = statesint;
  else
    if (! isvector (states))
      error ("hmmestimate: states must be a non-empty vector");
    endif
    if (! all (ismember (states, 1:max (states))))
      index = max ((ismember (states, 1:max (states)) == 0) .* (1:len));
      error (["hmmestimate: states(" int2str (index) ") not feasible"]);
    endif
  endif

  # Estimate the number of different states as the max of states  
  nstate = max (states);
  # Estimate the number of different outputs as the max of sequence
  noutput = max (sequence);

  # transprobest is empty if pseudotransitions is not specified
  if (isempty (transprobest))
    # outprobest is not empty if pseudoemissions is specified
    if (! isempty (outprobest))
      if (nstate > rows (outprobest))
        error ("hmmestimate: not enough rows in pseudoemissions");
      endif
      # The number of states is specified by pseudoemissions
      nstate = rows (outprobest);
    endif
    transprobest = zeros (nstate, nstate);
  else
    if (nstate > rows (transprobest))
      error ("hmmestimate: not enough rows in pseudotransitions");
    endif
    # The number of states is given by pseudotransitions
    nstate = rows (transprobest);
  endif

  # outprobest is empty if pseudoemissions is not specified
  if (isempty (outprobest))
    outprobest = zeros (nstate, noutput);
  else
    if (noutput > columns (outprobest))
      error ("hmmestimate: not enough columns in pseudoemissions");
    endif
    # Number of outputs is specified by pseudoemissions
    noutput = columns (outprobest);
    if (rows (outprobest) != nstate)
      error ("hmmestimate: pseudoemissions must have the same number of rows as pseudotransitions");
    endif
  endif

  # Assume that the model started in state 1
  cstate = 1;
  for i = 1:len
    # Count the number of transitions for each state pair
    transprobest(cstate, states(i)) ++;
    cstate = states (i);
    # Count the number of outputs for each state output pair
    outprobest(cstate, sequence(i)) ++;
  endfor

  # transprobest and outprobest contain counted numbers
  # Each row in transprobest and outprobest should contain estimated
  # probabilities
  # => scale so that the sum is 1
  # A zero row remains zero
  # - for transprobest
  s = sum (transprobest, 2);
  s(s == 0) = 1;
  transprobest = transprobest ./ (s * ones (1, nstate));
  # - for outprobest
  s = sum (outprobest, 2);
  s(s == 0) = 1;
  outprobest = outprobest ./ (s * ones (1, noutput));

endfunction

%!test
%! sequence = [1, 2, 1, 1, 1, 2, 2, 1, 2, 3, 3, 3, 3, 2, 3, 1, 1, 1, 1, 3, 3, 2, 3, 1, 3];
%! states = [1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1];
%! [transprobest, outprobest] = hmmestimate (sequence, states);
%! expectedtransprob = [0.88889, 0.11111; 0.28571, 0.71429];
%! expectedoutprob = [0.16667, 0.33333, 0.50000; 1.00000, 0.00000, 0.00000];
%! assert (transprobest, expectedtransprob, 0.001);
%! assert (outprobest, expectedoutprob, 0.001);

%!test
%! sequence = {'A', 'B', 'A', 'A', 'A', 'B', 'B', 'A', 'B', 'C', 'C', 'C', 'C', 'B', 'C', 'A', 'A', 'A', 'A', 'C', 'C', 'B', 'C', 'A', 'C'};
%! states = {'One', 'One', 'Two', 'Two', 'Two', 'One', 'One', 'One', 'One', 'One', 'One', 'One', 'One', 'One', 'One', 'Two', 'Two', 'Two', 'Two', 'One', 'One', 'One', 'One', 'One', 'One'};
%! symbols = {'A', 'B', 'C'};
%! statenames = {'One', 'Two'};
%! [transprobest, outprobest] = hmmestimate (sequence, states, 'symbols', symbols, 'statenames', statenames);
%! expectedtransprob = [0.88889, 0.11111; 0.28571, 0.71429];
%! expectedoutprob = [0.16667, 0.33333, 0.50000; 1.00000, 0.00000, 0.00000];
%! assert (transprobest, expectedtransprob, 0.001);
%! assert (outprobest, expectedoutprob, 0.001);

%!test
%! sequence = [1, 2, 1, 1, 1, 2, 2, 1, 2, 3, 3, 3, 3, 2, 3, 1, 1, 1, 1, 3, 3, 2, 3, 1, 3];
%! states = [1, 1, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1];
%! pseudotransitions = [8, 2; 4, 6];
%! pseudoemissions = [2, 4, 4; 7, 2, 1];
%! [transprobest, outprobest] = hmmestimate (sequence, states, 'pseudotransitions', pseudotransitions, 'pseudoemissions', pseudoemissions);
%! expectedtransprob = [0.85714, 0.14286; 0.35294, 0.64706];
%! expectedoutprob = [0.178571, 0.357143, 0.464286; 0.823529, 0.117647, 0.058824];
%! assert (transprobest, expectedtransprob, 0.001);
%! assert (outprobest, expectedoutprob, 0.001);
