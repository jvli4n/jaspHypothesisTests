//
// Copyright (C) 2013-2018 University of Amsterdam
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public
// License along with this program.  If not, see
// <http://www.gnu.org/licenses/>.
//
import QtQuick
import QtQuick.Layouts
import JASP.Controls
import JASP.Widgets
import JASP

Form
{
	id: form
    property string testName
    

	Formula { rhs: "dependent" }

	VariablesForm
	{
		infoLabel: qsTr("Input")
		preferredHeight: jaspTheme.smallDefaultVariablesFormHeight
		AvailableVariablesList { name: "allVariablesList" }
		AssignedVariablesList { name: "dependent"; title: qsTr("Variables"); info: qsTr("In this box the dependent variable is selected.") ; allowedColumns: ["scale"]; minNumericLevels: 2 }
	}

	Group
	{
        title: qsTr("")
		DoubleField { name: "testValue";	label: qsTr("Test value:"); info: qsTr("Test value specified in the null hypothesis. The mean of the data is compared to this value. Set to 0 by default, which can be changed by the user.")	;defaultValue: 0;	negativeValues: true	}
	    DoubleField { name: "zTestSd";		label: qsTr("Std. deviation:"); info: qsTr("The standard deviation applied in the Z test. Set to 1 by default, which can be changed by the user.") ;defaultValue: 1.0;	visible: testName === "zTest"	}
	}

	Group
	{
		title: qsTr("Additional Statistics")
		Layout.rowSpan: 2
		CheckBox
		{
            name: "meanDifference";			label: qsTr("Location estimate"); info: qsTr("Average difference between the data points and the test value. For the Student's t-test and the Z test the location difference estimate is given by the mean difference divided by the (hypothesized) standard deviation d; for the Wilcoxon signed-rank test, the location difference estimate is given by the Hodges-Lehmann estimate.")
			CheckBox
			{
				name: "meanDifferenceCi";	label: qsTr("Confidence interval"); info: qsTr("Confidence interval for the location parameter. By default, the confidence interval is set to 95%. This can be changed into the desired percentage.")
				childrenOnSameRow: true
				CIField { name: "meanDifferenceCiLevel" }
			}
		}

		CheckBox
		{
			name: "effectSize";				label: qsTr("Effect size"); info: qsTr("For the Student t-test, the effect size is given by Cohen's d; for the Wilcoxon test, the effect size is given by the matched rank biserial correlation; for the Z test, the effect size is given by Cohen's d (based on the provided population standard deviation).")
			CheckBox
			{
				name: "effectSizeCi"; label: qsTr("Confidence interval"); info: qsTr("Confidence interval for the effect size.")
				childrenOnSameRow: true
				CIField { name: "effectSizeCiLevel" }
			}
		}
		CheckBox { name: "descriptives";	label: qsTr("Descriptives"); info: qsTr("Sample size, sample mean, sample standard deviation, standard error of the mean for each measure.") }
		CheckBox { name: "vovkSellke";	label: qsTr("Vovk-Sellke maximum p-ratio"); info: qsTr("Shows the maximum ratio of the likelihood of the obtained p value under H1 vs the likelihood of the obtained p value under H0. For example, if the two-sided p-value equals .05, the Vovk-Sellke MPR equals 2.46, indicating that this p-value is at most 2.46 times more likely to occur under H1 than under H0.") }
	}

	RadioButtonGroup
	{
		name: "alternative"
		title: qsTr("Alternative Hypothesis")
		RadioButton { value: "twoSided";		label: qsTr("≠ Test value"); info: qsTr("Two sided alternative hypothesis that the sample mean is not equal to the test value. Selected by default."); checked: true	}
		RadioButton { value: "greater";	label: qsTr("> Test value")	; info: qsTr("One sided alternative hypothesis that the sample mean is greater than the test value.")				}
		RadioButton { value: "less";		label: qsTr("< Test value")	; info: qsTr("One sided alternative hypothesis that the sample mean is less than the test value.")				}
	}

	Group
	{
		title: qsTr("Assumption checks")
		CheckBox { name: "normalityTest"; label: qsTr("Normality"); info: qsTr("Shapiro-Wilk test of normality.") }
		CheckBox { name: "qqPlot";		 	label: qsTr("Q-Q plot residuals"); info: qsTr("Q-Q plot of the standardized residuals.") }

	}
	Group
	{
		title: qsTr("Plots")
		Layout.rowSpan: 2
		CheckBox
		{
			name: "descriptivesPlot";		label: qsTr("Descriptives plots"); info: qsTr("Displays the sample mean and the confidence interval. The confidence interval is set at 95% by default and can be changed.")
			CIField { name: "descriptivesPlotCiLevel";	label: qsTr("Confidence interval") }
		}
		CheckBox
		{
			name: "raincloudPlot"; label: qsTr("Raincloud plots"); info: qsTr("Displays the individual data points, box plot, and density.")
			CheckBox { name: "raincloudPlotHorizontal"; label: qsTr("Horizontal display"); info: qsTr("Changes the orientation of the raincloud plot so that the x-axis represents the dependent variable.") }
		}
		// Common.BarPlots
		// {
		// 	framework:	Classical
		// }


	}
	RadioButtonGroup
	{
		name: "naAction"
		title: qsTr("Missing Values")
		RadioButton { value: "perVariable";	label: qsTr("Exclude cases per variable"); info: qsTr("In case of multiple t-tests within a single analysis, each t-test will be conducted using all cases with valid data for the dependent variable for the particular t-test. Sample sizes may therefore vary across the tests. This option is selected by default."); checked: true }
		RadioButton { value: "listwise";				label: qsTr("Exclude cases listwise"); info: qsTr("In case of multiple t-tests within a single analysis, each t-test will be conducted using only cases with valid data for all dependent variables. Sample size is therefore constant across the tests.")						}
	}
}