//  #**************************************************************************
//  #
//  #    Copyright (C) 2025  Wolfram Diestel
//  #
//  #    This program is free software; you can redistribute it and/or modify
//  #    it under the terms of the GNU General Public License as published by
//  #    the Free Software Foundation; either version 2 of the License, or
//  #    (at your option) any later version.
//  #
//  #    This program is distributed in the hope that it will be useful,
//  #    but WITHOUT ANY WARRANTY; without even the implied warranty of
//  #    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  #    GNU General Public License for more details.
//  #
//  #    You should have received a copy of the GNU General Public License
//  #    along with this program; if not, write to the Free Software
//  #    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
//  #
//  #    Send comments and bug fixes to diestel@steloj.de
//  #
//  #**************************************************************************/

package de.steloj.respiro;

import java.text.RuleBasedCollator;
import java.text.ParseException;

public class ChuvashCollator extends RuleBasedCollator {

    static final String ChuvashSortRules = " = '|' < \u0430,\u0410 < \u04D1,\u04D0 < \u0431,\u0411 < \u0432,\u0412 < \u0433,\u0413 < \u0434,\u0414 < \u0435,\u0415 < \u0451,\u0401 < \u04D7,\u04D6 < \u0436,\u0416 < \u0437,\u0417 < \u0438,\u0418 < \u0439,\u0419 < \u043a,\u041a < \u043b,\u041b < \u043c,\u041c < \u043d,\u041d < \u043e,\u041e < \u043f,\u041f < \u0440,\u0420 < \u0441,\u0421 < \u04AB,\u04AA,\u00E7,\u00C7 < \u0442,\u0422 < \u0443,\u0423 < \u04F3,\u04F2 < \u0444,\u0424 < \u0445,\u0425 < \u0446,\u0426 < \u0447,\u0427 < \u0448,\u0428 < \u0449,\u0429 < \u044a,\u042a < \u044b,\u042b < \u044c,\u042c < \u044d,\u042d < \u044e,\u042e < \u044f,\u042f";

    public ChuvashCollator() throws ParseException {
	    super(ChuvashSortRules);
    }
}
