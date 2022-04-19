// Noaghea Marian-Florentin 333CC
#ifndef STACK_H_
#define STACK_H_

#include <stdio.h>
#include <stdlib.h>

typedef struct Node {
    char nume[50];
    char numep[50];
    int numere;
	int siruri;
	int booleeni;
	int liste;
	int obiecte;
	int null;
	
	int index;
} Node;

typedef Node Item;


typedef struct StackNode{
	Item elem;
	struct StackNode *next;
}StackNode;

typedef StackNode TCelSt;
typedef StackNode *ACelSt;

typedef struct Stack{
	StackNode* head;
	long size;
}Stack;

typedef Stack TStiva;
typedef Stack *ASt;

Node createNode(void) {
	Node node;
	node.numere= 0;
	node.siruri= 0;
	node.booleeni= 0;
	node.liste= 0;
	node.obiecte= 0;
	node.null= 0;

	node.index = 0;

	return node;

}

Stack* createStack(void){
	
	Stack* stack = (Stack*) malloc(sizeof(Stack));
	stack->head = NULL;
	stack->size = 0;
	return stack;
}

int isStackEmpty(Stack* stack){
	
	if (stack->head == NULL)
		return 1;
	return 0;
}
//adauga un element in stiva
void push(Stack *stack, Item elem){
	StackNode* newelem = (StackNode*) malloc(sizeof(StackNode));
	newelem->elem = elem;
	if (isStackEmpty(stack))
		{
			newelem->next = NULL;
			stack->head = newelem;
			stack->size++;
			return;
		}
	newelem->next = stack->head;
	stack->head = newelem;
	stack->size++;
}
//returneaza varful stivei
Item top(Stack *stack){	
    Node n;
	if (isStackEmpty(stack))
        return n;
	return stack->head->elem;
} 

//elimina varful stivei din stiva
void pop(Stack *stack){
	if (isStackEmpty(stack))
		return;
	StackNode* aux = stack->head;
	stack->head = stack->head->next;
	free(aux);
	stack->size--;
}

//dezaloca stiva
void destroyStack(Stack *stack){
	while (!isStackEmpty(stack))
		{
			pop(stack);
		}
		free(stack);
}

void printAndDestroyStack(Stack *stack) {
	while (!isStackEmpty(stack)) {
		//printf("%d ", top(stack));
		pop(stack);
	}

	free(stack);
}

#endif 