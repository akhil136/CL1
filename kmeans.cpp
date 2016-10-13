#include <iostream>
#include <cmath>
#include <cstdlib>
using namespace std;
 
class kmeans{	
	int num_points;
	int k;
	int iterations;
	int data[100][2];
	int means[100][2];
	int labels[100];
	public:
		kmeans()
		{
			cout<<"type number of clusters";
			cin>>k;
			cout<<"type number of data points";
			cin>>num_points;
			cout<<"Enter xy of data points";
			for(int i=0;i<num_points;i++)
			{
				cin>>data[i][0]>>data[i][1];
			}
			cout<<"type max iterations";
			cin>>iterations;
		}

		int do_clustering()
		{
			for(int i=0;i<k;i++)
			{
				means[i][0]=data[i][0];
				means[i][1]=data[i][1];
			}
			int iter=0;
			while(iter<iterations)
			{
				iter++;
				
				//assign labels
				assign_label();
				cout<<"lables\n";
				for(int m=0;m<num_points;m++)
				{
					cout<<labels[m]<<" \n";
				}

				//update cluster means
				update_cluster_mean();
				cout<<"cluster means\n";
				for(int m=0;m<k;m++)
				{
					cout<<means[m][0]<<" "<<means[m][1]<<"\n";
				}				
			}
			return 0;
		}

		int assign_label()
		{
			for(int i=0;i<num_points;i++)
			{
				labels[i]=find_minimum_distance(i);
			}
			return 0;
		}

		int find_minimum_distance(int index){
			int dist[k];
			for(int h=0;h<k;h++)
			{
				dist[h]=0;
			}
			for(int j=0;j<k;j++)
			{
				int dx=abs(means[j][0]-data[index][0]);
				int dy=abs(means[j][1]-data[index][1]);
				dist[j]=sqrt((dx*dx)+(dy*dy));
			}
			return argmin(dist);
		}

		int argmin(int * f)
		{
			int min=0;
			int min_dist=f[0];
			for (int n=1;n<k;n++)
			{
				if(f[n]<min_dist)
				{
					min=n;
				}
			}
			return min;
		}

		int update_cluster_mean()
		{
			int new_clusters[k][3];
			
			for(int m=0;m<k;m++)
			{
				new_clusters[m][0]=0;
				new_clusters[m][1]=0;
				new_clusters[m][2]=0;
			}

			for(int i=0;i<num_points;i++)
			{
				new_clusters[labels[i]][0]+=data[i][0];
				new_clusters[labels[i]][1]+=data[i][1];
				new_clusters[labels[i]][2]+=1;		
			}

			for(int m=0;m<k;m++)
			{
				if(new_clusters[m][2]==0)
				{
					new_clusters[m][0]=data[num_points][0];
					new_clusters[m][1]=data[num_points][2];
				}
				else
				{
					new_clusters[m][0]/=new_clusters[m][2];
					new_clusters[m][1]/=new_clusters[m][2];
				}
			}

			for(int m=0;m<k;m++)
			{
				means[m][0]=new_clusters[m][0];
				means[m][1]=new_clusters[m][1];
			}
			return 0;
		}

		

};


int main()
{
kmeans *kp=new kmeans();
kp->do_clustering();

return 0;
}



/*

*/