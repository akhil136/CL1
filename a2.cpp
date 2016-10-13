#include <iostream>
#include <pthread.h>
#include <stdlib.h>
#include <sched.h>

using namespace std;
int N;
struct args
{
  int* a;
  int first;
  int last;
};

void print(int a[], const int& N)
{
    for(int i = 0 ; i < N ; i++)
        cout << "array[" << i << "] = " << a[i] << endl;
} 
    int pivot(int arr[], int low_index, int high_index) {
        int i, j, temp, key;
        key = arr[low_index];
        i= low_index + 1;
        j= high_index;
        while(1) {
            while(i < high_index && key >= arr[i]) i++;
            while(key < arr[j]) j--;

            if(i < j) {
                temp = arr[i];
                arr[i] = arr[j];
                arr[j] = temp;
            } else {
                temp= arr[low_index];
                arr[low_index] = arr[j];
                arr[j]= temp;
                return(j);
            }
        }
    }
 
void* quickSort(void* arg)
{

    pthread_t id=pthread_self();

    args* ar=(args*)arg;
    int pivotElement;
    pthread_t threads[2];
    
 
    if(ar->first < ar->last)
    {
       
        pivotElement = pivot(ar->a, ar->first, ar->last);
         cout<<"Thread number "<<id<<" executing on core "<<sched_getcpu()<<" found pivotElement "<<ar->a[pivotElement]<<"\n";

        args array1;
        array1.a=new int[N];
        array1.a=ar->a;
        array1.first=ar->first;
        array1.last=pivotElement-1;
        args* x=&array1;
        int rc = pthread_create(&threads[0], NULL, &quickSort, (void *)x);

        args array2;
        array2.a=new int[N];
        array2.a=ar->a;
        array2.first=pivotElement+1;
        array2.last=ar->last;
        args* y=&array2;
        int rc1 = pthread_create(&threads[1], NULL, &quickSort, (void *)y);

        pthread_join(threads[0], NULL);
        pthread_join(threads[1], NULL);
    }
}
 


int main()
{
    
    cout<<"\nEnter number of elements in array:  ";
    cin>>N;
    int test[N]; 
    cout<<"\nNow enter Array ELements:  \n";
    for(int i=0;i<N;i++)
    {cin>>test[i];}
 
    cout << "Before sorting : " << endl;
    print(test, N);
 
    args array;
    array.a=new int[N];
    array.a=test;
    array.first=0;
    array.last=N-1;

    quickSort(&array);
 
    cout << endl << endl << "After sorting : " << endl;
    print(test, N);
     
    return 0;
}
