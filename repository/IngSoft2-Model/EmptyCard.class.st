Class {
	#name : #EmptyCard,
	#superclass : #Object,
	#classInstVars : [
		'holder'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #Initialization }
EmptyCard class >> holder: aColor [ 
	
	holder:= aColor.
]

{ #category : #Information }
EmptyCard >> isEmpty [
	^true.
]

{ #category : #Effect }
EmptyCard >> selectTarget: aTarget [

	Error signal:
		'Redo card cannot be played because there are no cards that have been played before'
]
