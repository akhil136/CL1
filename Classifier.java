import java.util.*;
import java.io.*;

import weka.classifiers.*;
import weka.classifiers.bayes.NaiveBayes;
import weka.core.*;


public class Classifier {
	
	public static void main(String[] args) throws Exception
	{
		BufferedReader br=new BufferedReader(new FileReader("src/test.arff"));
		Instances train=new Instances(br);
		train.setClassIndex(train.numAttributes()-1);
		
		NaiveBayes nb=new NaiveBayes();
		nb.buildClassifier(train);
		
		Evaluation eval=new Evaluation(train);
		eval.crossValidateModel(nb, train, 10, new Random(1));
		
		System.out.println(eval.toSummaryString());
		System.out.println(eval.toClassDetailsString());
		System.out.println(eval.toMatrixString());
	}

}
