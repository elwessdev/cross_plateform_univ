import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';


// Define the question type
interface Question {
    question: string;
    options: string[];
    correctAnswer: number;
}

// Sample quiz data
const quizData: Question[] = [
    {
        question: "Which language runs in a web browser?",
        options: [
            "Java", 
            "Python", 
            "C++", 
            "JavaScript"
        ],
        correctAnswer: 3
    },
    {
        question: "What does CSS stand for?",
        options: [
            "Central Style Sheets", 
            "Cascading Style Sheets", 
            "Computer Style Sheets", 
            "Colorful Style Sheets"
        ],
        correctAnswer: 1
    },
    {
        question: "What does HTML stand for?",
        options: [
            "Hypertext Markup Language", 
            "Hypertext Markdown Language", 
            "Hyperloop Machine Language", 
            "Helicopter Terminal Markup Language"
        ],
        correctAnswer: 0
    },
    {
        question: "Which year was JavaScript launched?",
        options: ["1996", "1995", "1994", "None of the above"],
        correctAnswer: 1
    },
];

const Quiz = () => {
    const [currentQuestion, setCurrentQuestion] = useState(0);
    const [score, setScore] = useState(0);
    const [showScore, setShowScore] = useState(false);
    const [selectedOption, setSelectedOption] = useState<number | null>(null);
    const [isAnswered, setIsAnswered] = useState(false);

    useEffect(() => {
        setIsAnswered(false);
        setSelectedOption(null);
    }, [currentQuestion, showScore]);

    const handleAnswerClick = (selectedIndex: number) => {
        if (isAnswered) return;
        setSelectedOption(selectedIndex);
        setIsAnswered(true);
        if (selectedIndex === quizData[currentQuestion].correctAnswer) {
            setScore(score + 1);
        }
        setTimeout(() => {
            handleNextQuestion();
        }, 1000);
    };

    const handleNextQuestion = () => {
        const nextQuestion = currentQuestion + 1;
        if (nextQuestion < quizData.length) {
            setCurrentQuestion(nextQuestion);
        } else {
            setShowScore(true);
        }
    };

    const restartQuiz = () => {
        setCurrentQuestion(0);
        setScore(0);
        setShowScore(false);
        setIsAnswered(false);
        setSelectedOption(null);
    };

    return (
        <SafeAreaView style={styles.container}>
            {showScore ? (
                <View style={styles.scoreSection}>
                    <Text style={styles.scoreText}>
                        You scored {score} out of {quizData.length}
                    </Text>
                    <View style={styles.buttonContainer}>
                        <TouchableOpacity style={styles.button} onPress={restartQuiz}>
                            <Text style={styles.buttonText}>Restart Quiz</Text>
                        </TouchableOpacity>
                    </View>
                </View>
            ) : (
                <>
                    <View style={styles.quizHeader}>
                        <Text style={styles.questionCount}>
                            Question {currentQuestion + 1}/{quizData.length}
                        </Text>
                    </View>
                    
                    <View style={styles.questionSection}>
                        <Text style={styles.questionText}>{quizData[currentQuestion].question}</Text>
                    </View>
                    
                    <View style={styles.answerSection}>
                        {quizData[currentQuestion].options.map((option, index) => {
                            let optionStyle = styles.option;
                            if (isAnswered) {
                                if (index === quizData[currentQuestion].correctAnswer) {
                                    optionStyle = [styles.option, styles.correctOption];
                                } else if (index === selectedOption) {
                                    optionStyle = [styles.option, styles.wrongOption];
                                }
                            }
                            
                            return (
                                <TouchableOpacity
                                    key={index}
                                    style={optionStyle}
                                    onPress={() => handleAnswerClick(index)}
                                    disabled={isAnswered}
                                >
                                    <Text style={styles.optionText}>{option}</Text>
                                </TouchableOpacity>
                            );
                        })}
                    </View>
                </>
            )}
        </SafeAreaView>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f8f9fa',
        padding: 20,
    },
    quizHeader: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginBottom: 20,
    },
    questionCount: {
        fontSize: 18,
        fontWeight: 'bold',
        color: '#343a40',
    },
    timer: {
        fontSize: 18,
        fontWeight: 'bold',
        color: '#dc3545',
    },
    questionSection: {
        marginBottom: 20,
        backgroundColor: 'white',
        padding: 20,
        borderRadius: 10,
        elevation: 3,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.1,
        shadowRadius: 3,
    },
    questionText: {
        fontSize: 22,
        fontWeight: 'bold',
        color: '#212529',
        textAlign: 'center',
    },
    answerSection: {
        width: '100%',
    },
    option: {
        backgroundColor: '#FFFF',
        padding: 15,
        marginVertical: 8,
        borderRadius: 8,
    },
    correctOption: {
        backgroundColor: '#28a745',
    },
    wrongOption: {
        backgroundColor: '#dc3545',
    },
    optionText: {
        color: '#222',
        fontSize: 18,
        textAlign: 'center',
    },
    scoreSection: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    scoreText: {
        fontSize: 24,
        fontWeight: 'bold',
        marginBottom: 30,
    },
    buttonContainer: {
        width: '100%',
        alignItems: 'center',
    },
    button: {
        backgroundColor: '#00ff6eff',
        padding: 15,
        borderRadius: 8,
        marginVertical: 10,
        width: '80%',
    },
    homeButton: {
        backgroundColor: '#6c757d',
    },
    buttonText: {
        color: 'white',
        fontSize: 18,
        textAlign: 'center',
        fontWeight: 'bold',
    },
});

export default Quiz;