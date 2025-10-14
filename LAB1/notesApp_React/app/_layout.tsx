import { DarkTheme, DefaultTheme, ThemeProvider } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { StatusBar } from 'expo-status-bar';
import 'react-native-reanimated';
import { useColorScheme } from '@/hooks/use-color-scheme';
import HomeScreen from "./screens/HomeScreen";
import NotesScreen from "./screens/NotesScreen";

export default function RootLayout() {
  const colorScheme = useColorScheme();

  const Stack = createNativeStackNavigator();
  
  return (
    <ThemeProvider value={colorScheme === 'dark' ? DarkTheme : DefaultTheme}>
      <Stack.Navigator initialRouteName="Home">
        <Stack.Screen
          name="Home"
          component={HomeScreen}
          options={{
            headerStyle: {
              backgroundColor: "#f4511e",
            },
            headerTintColor: "#fff",
          }}
        />
        <Stack.Screen
          name="Notes"
          component={NotesScreen}
        />
      </Stack.Navigator>
      <StatusBar style="auto" />
    </ThemeProvider>
  );
}
