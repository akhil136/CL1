import java.io.*;

import weka.classifiers.*;
import weka.core.Instances;
import weka.classifiers.trees.J48;


public class Classifier1 {
	
	public static void main(String[] args) throws Exception
	{
		BufferedReader br=new BufferedReader(new FileReader("src/test.arff"));
		Instances train=new Instances(br);
		train.setClassIndex(train.numAttributes()-1);
		
		br=new BufferedReader(new FileReader("src/test.arff"));
		Instances test=new Instances(br);
		test.setClassIndex(test.numAttributes()-1);
		br.close();
		
		J48 tree=new J48();
		tree.setOptions(null);
		tree.buildClassifier(train);
		
		Evaluation eval=new Evaluation(train);
		eval.evaluateModel(tree,test);
		System.out.println(eval.toSummaryString());
		System.out.println(eval.toClassDetailsString());
		System.out.println(eval.toMatrixString());
		
		
	}

}
