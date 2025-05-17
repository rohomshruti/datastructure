#include<iostream>
#include<string>
using namespace std;
class BST{
    public:
    string name;
    int salary;
    BST *left;
    BST *right;
    BST(string n,int s){
        name=n;
        salary=s;
        left=right=NULL;
    }
    void insert(BST *root,string n,int s ){
        BST *current=root;
        BST *prev=nullptr;
        while(current!=NULL){
            prev=current;
            if(s<current->salary){
                current =current->left;
            }else{
                current=current->right;
            }
        }
        BST *temp=new BST(n,s);
        if(temp->salary<prev->salary){
            prev->left=temp;
        }else{
            prev->right=temp;
        }
    }
    void display(BST *root){
        if(root==NULL)return;
        display(root->left);
        cout<<root->name<<"\t"<<root->salary<<"\n";
        display(root->right);
    }
    void search(BST *root,string n,int s){
        if(root==nullptr){
            cout<<"not found";
            return;
        }
        if(s==root->salary && n==root->name){
            cout<<"employee found";
            return;
        }
        else if(s<root->salary){
            search(root->left,n,s);
        }
        else{
            search(root->right,n,s);
        }
   
    }
    void update(BST *root,string n,int s,int cur)
    {
      deletes(root,cur);
      insert(root,n,s);
    }
    void deletes(BST *root,int s){
        BST *current=nullptr;
        BST *temp=root;
        BST *previous=nullptr;
        while(temp!=nullptr && temp->salary!=s){
            previous=temp;
            if(s<temp->salary){
                temp=temp->left;
            }else{
                temp=temp->right;
            }
        }
        if(temp==nullptr){
            cout<<"not";
            return;
        }
        if(temp->left==nullptr && temp->right==nullptr){
            if(previous->left==temp){
                previous->left=nullptr;
            }else{
                previous->right=nullptr;
            }
            delete temp;
            cout<<"deleted";
        }
        else if(temp->left==nullptr || temp->right==nullptr){
            if(temp->left!=nullptr){
                current=temp->left;
            }else{
                current=temp->right;
            }
            if(previous->left==temp){
                previous->left=current;
            }else{
                previous->right=current;
            }
            delete temp;
            cout<<"deleted";
        }
        else{
            BST *suc=temp->right;
            BST *parentsuc=temp;
            while(suc->left!=nullptr){
                parentsuc=suc;
                suc=suc->left;
            }
            temp->name=suc->name;
            temp->salary=suc->salary;
            parentsuc->left=suc->right;
            delete suc;
            cout<<"deleted";
        }
      
    }
    int count(BST *root){
        if(root==NULL)return 0;
        return 1+count(root->left)+count(root->right);

    }
    int sum(BST *root){
        if(root==NULL)return 0;
        return root->salary+sum(root->left)+sum(root->right);

    }
    
};
int main(){
    int cur;
    int s;
    string n;
    int ch;
    BST *root=NULL;
    do{
        cout<<"1.insert\t2.display\t3.serach\t4.count\5.sum\t6.delete\t7.update\n";
        cin>>ch;
        switch(ch){
            case 1:cout<<"enter name and salary";
            cin>>n>>s;
            if(root==NULL){
                root=new BST(n,s);
            }
            else{
                root->insert(root,n,s);
            }
            break;
            case 2:root->display(root);
            break;
            case 3:cout<<"enter name and salary";
            cin>>n>>s;
            root->search(root,n,s);
            break;
            case 4:cout<<root->count(root);
            break;
            case 5:cout<<root->sum(root);
            break;
            case 6:cout<<"enter salary";
            cin>>s;
            root->deletes(root,s);
            break;
            case 7:cout<<"enter current salary";
            cin>>cur;
            cout<<"enter new name and salary";
            cin>>n>>s;
            root->update(root,n,s,cur);
            break;
            default:cout<<"wrong";
            break;

        }

    }while(ch!=0);
    return 0;
}
